# @summary Manage the state of an installed plugin
#
# This can be used to manage the state of individual plugins. Note that it does
# no dependency management and that's all up to the user. This is particularly
# important to remember when also purging plugins.
#
# @param version
#   The version to ensure
#
# @param config_filename
#   Name of the config file for this plugin. Note config_content must also be
#   set.
#
# @param config_content
#   Content of the config file for this plugin. It is up to the caller to
#   create this content from a template or any other mean. config_filename must
#   also be set.
#
# @param update_url
#
# @param source
#   Direct URL from which to download plugin without modification.  This is
#   particularly useful for development and testing of plugins which may not be
#   hosted in the typical Jenkins' plugin directory structure.  E.g.,
#
#   https://example.org/myplugin.hpi
#
# @param extension
#   When no source is given, this extension is used
#
# @param digest_string
#   An optional digest string to verify integrity. The digest_type parameter
#   describes content of this string. It's passed to puppet-archive to verify
#   the downloaded plugin.
#
# @param digest_type
#   This parameter describes the content of digest_string. It's passed to
#   puppet-archive to verify the downloaded plugin.
#
# @param enabled
#   Ensure whether the plugin is enabled or not. Disabled plugins are still
#   installed.
#
# @param pin
#   Pin the plugin to a specific version. This prevents the updater from
#   updating it.
#
define jenkins::plugin (
  Optional[String] $version         = undef,
  Optional[String] $config_filename = undef,
  Optional[String] $config_content  = undef,
  Optional[String] $update_url      = undef,
  Optional[String] $source          = undef,
  Enum['hpi', 'jpi'] $extension     = 'hpi',
  Optional[String] $digest_string   = undef,
  Boolean $enabled                  = true,
  String $digest_type               = 'sha1',
  Boolean $pin                      = false,
) {
  include jenkins

  if $jenkins::manage_service and $jenkins::service_restart {
    $notify = Class['jenkins::service']
  } else {
    $notify = undef
  }

  if $jenkins::manage_datadirs {
    $plugindir = File[$jenkins::plugin_dir]
  } else {
    $plugindir = undef
  }

  include jenkins

  if $version {
    $plugins_host = $update_url ? {
      undef   => $jenkins::default_plugins_host,
      default => $update_url,
    }
    $base_url = "${plugins_host}/download/plugins/${name}/${version}/"
    # Escape +'s in $version when constructing $search.
    # * We can't use single quotes for the replacement string because
    #   puppet 3 and puppet 4 interpret '\\' differently.
    # * We can't use double quotes without a variable interpolation or
    #   lint complains.
    $empty    = '' # lint:ignore:empty_string_assignment
    $escver   = regsubst ($version, '\+', "${empty}\\\\+", 'G')
    $search   = "^${name} ${escver}$"
  }
  else {
    $plugins_host = $update_url ? {
      undef   => $jenkins::default_plugins_host,
      default => $update_url,
    }
    $base_url = "${plugins_host}/latest/"
    $search   = "^${name} "
  }

  # if $source is specified, it overrides any other URL construction
  $download_url = $source ? {
    undef   => "${base_url}${name}.${extension}",
    default => $source,
  }

  $plugin_ext = regsubst($download_url, '^.*\.(hpi|jpi)$', '\1')
  $plugin     = "${name}.${plugin_ext}"
  # sanity check extension
  if ! $plugin_ext {
    fail("unsupported plugin extension in source url: ${download_url}")
  }

  $installed_plugins = fact('jenkins_plugins') ? {
    undef   => [],
    default => strip(split($facts['jenkins_plugins'], ',')),
  }

  # create a file resource for the download + unpacked plugin dir to prevent it
  # from being recursively deleted
  if $jenkins::purge_plugins {
    file { "${jenkins::plugin_dir}/${name}": }
  }

  if (empty(grep($installed_plugins, $search))) {
    $enabled_ensure = $enabled ? {
      false   => present,
      default => absent,
    }

    # at least as of jenkins 1.651, if the version of a plugin being downloaded
    # has a .hpi extension, and there is an existing version of the plugin
    # present with a .jpi extension, jenkins will actually delete the .hpi
    # version when restarted. Essentially making it impossible to
    # (up|down)grade a plugin from .jpi -> .hpi via puppet across extension
    # changes.  Regardless, we should be relying on jenkins to guess which
    # plugin archive to use and cleanup any conflicting extensions.
    $inverse_plugin_ext = $plugin_ext ? {
      'hpi'   => 'jpi',
      'jpi'   => 'hpi',
    }
    $inverse_plugin     = "${name}.${inverse_plugin_ext}"

    file { [
        "${jenkins::plugin_dir}/${inverse_plugin}",
        "${jenkins::plugin_dir}/${inverse_plugin}.disabled",
        "${jenkins::plugin_dir}/${inverse_plugin}.pinned",
      ]:
        ensure => absent,
        before => Archive[$plugin],
    }

    # Allow plugins that are already installed to be enabled/disabled.
    file { "${jenkins::plugin_dir}/${plugin}.disabled":
      ensure  => $enabled_ensure,
      owner   => $jenkins::user,
      group   => $jenkins::group,
      mode    => '0644',
      require => Archive[$plugin],
      notify  => $notify,
    }

    $pinned_ensure = $pin ? {
      true    => file,
      default => undef,
    }

    file { "${jenkins::plugin_dir}/${plugin}.pinned":
      ensure  => $pinned_ensure,
      owner   => $jenkins::user,
      group   => $jenkins::group,
      require => Archive[$plugin],
      notify  => $notify,
    }

    if $digest_string {
      $checksum_verify = true
      $checksum        = $digest_string
      $checksum_type   = $digest_type
    } else {
      $checksum_verify = false
      $checksum        = undef
      $checksum_type   = undef
    }

    exec { "force ${plugin}-${version}":
      command => "/bin/rm -rf ${jenkins::plugin_dir}/${plugin}",
    }
    -> archive { $plugin:
      source          => $download_url,
      path            => "${jenkins::plugin_dir}/${plugin}",
      checksum_verify => $checksum_verify,
      checksum        => $checksum,
      checksum_type   => $checksum_type,
      proxy_server    => $jenkins::proxy::url,
      cleanup         => false,
      extract         => false,
      require         => $plugindir,
      notify          => $notify,
    }
    $archive_require = Archive[$plugin]
  } else {
    $archive_require = undef
  }

  file { "${jenkins::plugin_dir}/${plugin}" :
    owner   => $jenkins::user,
    group   => $jenkins::group,
    mode    => '0644',
    require => $archive_require,
    before  => $notify,
  }

  if $config_filename {
    if $config_content == undef {
      fail 'To deploy config file for plugin, you need to specify both $config_filename and $config_content'
    }

    file { "${jenkins::localstatedir}/${config_filename}":
      ensure  => file,
      content => $config_content,
      owner   => $jenkins::user,
      group   => $jenkins::group,
      mode    => '0644',
      notify  => $notify,
    }
  }
}
