#
# config_filename = undef
#   Name of the config file for this plugin.
#
# config_content = undef
#   Content of the config file for this plugin. It is up to the caller to
#   create this content from a template or any other mean.
#
# update_url = undef
#
# source = undef
#   Direct URL from which to download plugin without modification.  This is
#   particularly useful for development and testing of plugins which may not be
#   hosted in the typical Jenkins' plugin directory structure.  E.g.,
#
#   https://example.org/myplugin.hpi
#
define jenkins::plugin(
  Optional[String] $version         = undef,
  Optional[String] $config_filename = undef,
  Optional[String] $config_content  = undef,
  Optional[String] $update_url      = undef,
  Optional[String] $source          = undef,
  Optional[String] $digest_string   = undef,
  Boolean $manage_config            = false,
  Boolean $enabled                  = true,
  String $digest_type               = 'sha1',
  Boolean $pin                      = false,
  # no worky
  Any $timeout                      = undef,
  # deprecated
  Any $plugin_dir                   = undef,
  Any $username                     = undef,
  Any $group                        = undef,
  Any $create_user                  = undef,
) {

  include jenkins

  if $jenkins::manage_service {
    $notify = Class['jenkins::service']
  } else {
    $notify = undef
  }

  if $jenkins::manage_datadirs {
    $plugindir = File[$jenkins::plugin_dir]
  } else {
    $plugindir = undef
  }

  if $timeout {
    warning('jenkins::plugin::timeout presently has effect')
  }

  if $plugin_dir {
    warning('jenkins::plugin::plugin_dir is deprecated and has no effect -- see jenkins::localstatedir')
  }
  if $username {
    warning('jenkins::plugin::username is deprecated and has no effect -- see jenkins::user')
  }
  if $group {
    warning('jenkins::plugin::group is deprecated and has no effect -- see jenkins::group')
  }
  if $create_user {
    warning('jenkins::plugin::create_user is deprecated and has no effect')
  }

  include jenkins

  if $version {
    $plugins_host = $update_url ? {
      undef   => $::jenkins::default_plugins_host,
      default => $update_url,
    }
    $base_url = "${plugins_host}/download/plugins/${name}/${version}/"
    # Escape +'s in $version when constructing $search.
    # * We can't use single quotes for the replacement string because
    #   puppet 3 and puppet 4 interpret '\\' differently.
    # * We can't use double quotes without a variable interpolation or
    #   lint complains.
    $empty    = ''
    $escver   = regsubst ($version, '\+', "${empty}\\\\+", 'G')
    $search   = "^${name} ${escver}$"
  }
  else {
    $plugins_host = $update_url ? {
      undef   => $::jenkins::default_plugins_host,
      default => $update_url,
    }
    $base_url = "${plugins_host}/latest/"
    $search   = "^${name} "
  }

  # if $source is specified, it overrides any other URL construction
  $download_url = $source ? {
    undef   => "${base_url}${name}.hpi",
    default => $source,
  }

  $plugin_ext = regsubst($download_url, '^.*\.(hpi|jpi)$', '\1')
  $plugin     = "${name}.jpi"
  # sanity check extension
  if ! $plugin_ext {
    fail("unsupported plugin extension in source url: ${download_url}")
  }

  $installed_plugins = fact('jenkins_plugins') ? {
    undef   => [],
    default => strip(split($::jenkins_plugins, ',')),
  }

  # create a file resource for the download + unpacked plugin dir to prevent it
  # from being recursively deleted
  if $::jenkins::purge_plugins {
    file { "${::jenkins::plugin_dir}/${name}": }
  }

  if (empty(grep($installed_plugins, $search))) {
    $enabled_ensure = $enabled ? {
      false   => present,
      default => absent,
    }

    # Allow plugins that are already installed to be enabled/disabled.
    file { "${::jenkins::plugin_dir}/${plugin}.disabled":
      ensure  => $enabled_ensure,
      owner   => $::jenkins::user,
      group   => $::jenkins::group,
      mode    => '0644',
      require => Archive[$plugin],
      notify  => $notify,
    }

    $pinned_ensure = $pin ? {
      true    => file,
      default => undef,
    }

    file { "${::jenkins::plugin_dir}/${plugin}.pinned":
      ensure  => $pinned_ensure,
      owner   => $::jenkins::user,
      group   => $::jenkins::group,
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

    exec{"force ${plugin}-${version}":
      command => "/bin/rm -rf ${::jenkins::plugin_dir}/${plugin}",
    }
    -> archive { $plugin:
      source          => $download_url,
      path            => "${::jenkins::plugin_dir}/${plugin}",
      checksum_verify => $checksum_verify,
      checksum        => $checksum,
      checksum_type   => $checksum_type,
      proxy_server    => $::jenkins::proxy::url,
      cleanup         => false,
      extract         => false,
      require         => $plugindir,
      notify          => $notify,
    }
    $archive_require = Archive[$plugin]
  } else {
    $archive_require = undef
  }

  file { "${::jenkins::plugin_dir}/${plugin}" :
    owner   => $::jenkins::user,
    group   => $::jenkins::group,
    mode    => '0644',
    require => $archive_require,
    before  => $notify,
  }

  if $manage_config {
    if $config_filename == undef or $config_content == undef {
      fail 'To deploy config file for plugin, you need to specify both $config_filename and $config_content'
    }

    file {"${::jenkins::localstatedir}/${config_filename}":
      ensure  => present,
      content => $config_content,
      owner   => $::jenkins::user,
      group   => $::jenkins::group,
      mode    => '0644',
      notify  => Class['::jenkins::service'],
    }
  }
}
