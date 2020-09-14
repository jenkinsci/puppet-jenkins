#
# This class manages the [Jenkins CI/CD service](https://jenkins.io/index.html).
#
# Note that if different jenkins listening port(s) are configured via
# ``jenkins::port``, ``jenkins::config_hash`` and/or a ``jenkins::sysconf``
# resource, "bad things" are likely to happen.  This is a known implementation
# problem with this module that can not be fixed without breaking backwards
# compatibility.
#
# @param version
#   package to install
#
#   * ``installed`` (Default)
#     do NOT update jenkins to the most recent version.
#   * ``latest``
#    automatically update the version of jenkins to the current version
#    available via your package manager.
#
# @param lts
#   use the upstream jenkins "Long Term Support" repos
#
#   * ``false``
#     Use the most up to date version of jenkins
#   * ``true`` (Default)
#     Use LTS version of jenkins
#
# @param repo
#   configure upstream jenkins package repos
#
#   ``false`` means do NOT configure the upstream jenkins package repo. This
#   means you'll manage a repo manually outside this module. This can also be
#   your distribution's repo.
#
# @param package_name
#   Optionally override the package name
#
# @param direct_download
#   URL to jenkins package
#
#   Ignore repository based package installation and download the package
#   directly.  Leave as `undef` (the default) to download using your OS package
#   manager
#
# @param package_cache_dir
#   Directory in which to store a ``direct_download`` package
#
# @param package_provider
#   Override the ``package`` resource provider
#
#   This *only has effect* when using ``direct_download``.
#
# @param manage_service
#   Enable management of ``Service[jenkins]`` resource
#
#   When setting to ``false`` please ensure something else defines
#   ``Service[jenkins]`` in order for some module functionality (e.g.
#   ``jenkins::cli``) to work properly
#
# @param service_enable
#   Enable (or not) the jenkins service
#
# @param service_ensure
#   Status of the jenkins service
#
#   * ``running`` (default)
#   * ``stopped``
#
# @param service_restart
#   Whether to restart the service on config_hash and plugins
#
# @param service_provider
#   Override ``Service[jenkins]`` resource provider
#
#   Setting this to ``undef`` on platforms with ``systemd`` will force the
#   usage of package provider sysv init scripts.
#
# @param config_hash
#   options to set in sysconfig/jenkins defaults/jenkins
#
#   (see jenkins::sysconf)
#
# @example Bulk sysconf
#   class{ 'jenkins':
#     config_hash => {
#       'HTTP_PORT' => { 'value' => '9090' },
#       'AJP_PORT'  => { 'value' => '9009' },
#     }
#   }
#
# @param plugin_hash
#   plugins to install
#
#   (see jenkins::plugin)
#
# @example Bulk plugin installation (code)
#   class{ 'jenkins::plugins':
#     plugin_hash => {
#       'git' => { version => '1.1.1' },
#       'parameterized-trigger' => {},
#       'multiple-scms' => {},
#       'git-client' => {},
#       'token-macro' => {},
#     }
#   }
#
# @example Bulk plugin installation (hiera)
#   jenkins::plugin_hash:
#      git:
#         version: '1.1.1'
#      parameterized-trigger: {}
#      multiple-scms: {}
#      git-client: {}
#      token-macro: {}
#
# @param job_hash
#   jobs to install
#
#   (see jenkins::job)
#
# @param user_hash
#   jenkins users to create
#
# @example Bulk user creation (code)
#   class{ 'jenkins':
#     user_hash => {
#       'user1' => {
#         'password' => 'pass1',
#          'email'   => 'user1@example.com',
#       }
#     }
#   }
#
# @example Bulk user creation (hiera)
#   jenkins::user_hash:
#     user:
#       password: 'pass1'
#       email: 'user1@example.com'
#
# @param configure_firewall
#   For folks that want to manage the puppetlabs firewall module.
#
#    * If it's not present in the catalog, nothing happens.
#    * If it is, you need to explicitly set this true / false.
#       * We didn't want you to have a service opened automatically, or
#       unreachable inexplicably.
#    * This default changed in v1.0 to be undef.
#
# @param install_java
#   use the ``puppetlabs-java`` module to install a JDK
#
#   Jenkins requires a JRE. Setting this to ``false`` means that you are
#   response for managing a JDK outside of this module.
#
# @param repo_proxy
#   proxy to download packages
#
#   This parameter is only relevant for ``yum`` repos managed by this module.
#
# @param proxy_host
#   proxy hostname for plugin installation via this module and the UpdateCenter
#
# @param proxy_port
#   proxy port for plugin installation via this module and the UpdateCenter
#
# @param no_proxy_list
#   List of hostname patterns to skip using the proxy.
#
#   * Only effective if "proxy_host" and "proxy_port" are set.
#   * Only applies to plugins installed via the UpdateCenter
#
# @param cli
#   install ``jenkins-cli.jar`` CLI utility
#
#   * force installation of the jenkins CLI jar to
#   ``$libdir/cli/jenkins-cli.jar``
#   * the cli is automatically installed when needed by components that use it,
#     such as the user and credentials types, and the security class
#   * CLI installation (both implicit and explicit) requires the ``unzip``
#   command
#
# @param cli_ssh_keyfile
#   Provides the location of an ssh private key file to make authenticated
#   connections to the Jenkins CLI.
#
# @param cli_username
#   Provides the username for authenticating to Jenkins via username and
#   password.
#
# @param cli_password
#   Provides the password for authenticating to Jenkins via username and
#   password. Needed if cli_username is specified.
#
# @param cli_password_file
#   Provides the password file for authenticating to Jenkins via username and
#   password. Needed if cli_username is specified and cli_password is undefined.
#
# @param cli_tries
#   Retries until giving up talking to jenkins API
#
# @param cli_try_sleep
#   Seconds between tries to contact jenkins API
#
# @param port
#   Jenkins listening HTTP port
#
#   Note that this value is used for CLI communication and firewall
#   configuration.  It does not configure the port on which the jenkins service
#   listens. (see config_hash)
#
# @param libdir
#   Path to jenkins core files
#
#   * Redhat: ``/usr/lib/jenkins``
#   * Debian: ``/usr/share/jenkins``
#
# @param sysconfdir
#   Controls the path to the "sysconfig" file that stores jenkins service
#   start-up variables
#
#   * RedHat: ``/etc/sysconfig/jenkins``
#   * Debian: ``/etc/default/jenkins``
#
# @param manage_datadirs
#   manage the local state dir, plugins dir and jobs dir
#
# @param localstatedir
#   base path, in the ``autoconf`` sense, for jenkins local data including jobs
#   and plugins
#
# @param executors
#   number of executors on the Jenkins master
#
# @param slaveagentport
#   jenkins slave agent
#
# @param manage_user
#   manage the system jenkins user
#
# @param user
#   system user that owns the jenkins master's files
#
# @param manage_group
#   manage the system jenkins group
#
# @param group
#   system group that owns the jenkins master's files
#
# @param default_plugins
#   List of default plugins installed by this module
#
#   The the ``credentials`` plugin is required for this module to properly
#   function.  No version is specified.  Set to ``[]`` if you want to explicitly
#   manage all plugins version
#
# @param default_plugins_host
#   Provide a way to override plugins host for all plugins
#
# @example Manage version of ``credentials`` plugin (hiera)
#   jenkins::default_plugins: []
#   jenkins::plugin_hash:
#     credentials:
#       version: 2.1.5
#       digest_string: 7db002e7b053f863e2ce96fb58abb98a9c01b09c
#       digest_type: sha1
#
# @param purge_plugins
#   Purge *all* plugins not explicitly managed by this module
#
#   This will result in plugins manually installed via the UpdateCenter being
#   removed.  Only enable this option if you want to manage all plugins (and
#   plugin dependencies) explicitly.
#
# @example Explicitly manage *all* plugins (hiera)
#   jenkins::default_plugins: []
#   jenkins::purge_plugins: true
#   jenkins::plugin_hash:
#     credentials:
#       version: '2.1.10'
#     support-core:
#       version: '2.38'
#     # support-core deps
#     metrics:
#       version: '3.1.2.9'
#     jackson2-api:
#       version: '2.7.3'
#     bouncycastle-api:
#       version: '2.16.0'
#     # /support-core deps
#
class jenkins(
  String $version                                 = $jenkins::params::version,
  Boolean $lts                                    = $jenkins::params::lts,
  Boolean $repo                                   = $jenkins::params::repo,
  String $package_name                            = $jenkins::params::package_name,
  Optional[String] $direct_download               = $jenkins::params::direct_download,
  Stdlib::Absolutepath $package_cache_dir         = $jenkins::params::package_cache_dir,
  Optional[String] $package_provider              = $jenkins::params::package_provider,
  Boolean $manage_service                         = true,
  Boolean $service_enable                         = $jenkins::params::service_enable,
  Enum['running', 'stopped'] $service_ensure      = $jenkins::params::service_ensure,
  Boolean $service_restart                        = $jenkins::params::service_restart,
  Optional[String] $service_provider              = $jenkins::params::service_provider,
  Hash $config_hash                               = {},
  Hash $plugin_hash                               = {},
  Hash $job_hash                                  = {},
  Hash $user_hash                                 = {},
  Boolean $configure_firewall                     = false,
  Boolean $install_java                           = $jenkins::params::install_java,
  Optional[String] $repo_proxy                    = undef,
  Optional[String] $proxy_host                    = undef,
  Optional[Integer] $proxy_port                   = undef,
  Optional[Array] $no_proxy_list                  = undef,
  Boolean $cli                                    = true,
  Optional[Stdlib::Absolutepath] $cli_ssh_keyfile = undef,
  Optional[String] $cli_username                  = undef,
  Optional[String] $cli_password                  = undef,
  Optional[String] $cli_password_file             = undef,
  Integer $cli_tries                              = $jenkins::params::cli_tries,
  Integer $cli_try_sleep                          = $jenkins::params::cli_try_sleep,
  Integer $port                                   = $jenkins::params::port,
  Stdlib::Absolutepath $libdir                    = $jenkins::params::libdir,
  Stdlib::Absolutepath $sysconfdir                = $jenkins::params::sysconfdir,
  Boolean $manage_datadirs                        = $jenkins::params::manage_datadirs,
  Stdlib::Absolutepath $localstatedir             = $jenkins::params::localstatedir,
  Optional[Integer] $executors                    = undef,
  Optional[Integer] $slaveagentport               = undef,
  Boolean $manage_user                            = $jenkins::params::manage_user,
  String $user                                    = $jenkins::params::user,
  Boolean $manage_group                           = $jenkins::params::manage_group,
  String $group                                   = $jenkins::params::group,
  Array $default_plugins                          = $jenkins::params::default_plugins,
  String $default_plugins_host                    = $jenkins::params::default_plugins_host,
  Boolean $purge_plugins                          = $jenkins::params::purge_plugins,
) inherits jenkins::params {

  if $purge_plugins and ! $manage_datadirs {
    warning('jenkins::purge_plugins has no effect unless jenkins::manage_datadirs is true')
  }

  # Construct the cli auth argument used in cli and cli_helper
  if $cli_ssh_keyfile {
    # SSH key auth
    if empty($cli_username) {
      fail('ERROR: Latest remoting free CLI (see https://issues.jenkins-ci.org/browse/JENKINS-41745) needs username for SSH Access (\$::jenkins::cli_username)')
    }
    $_cli_auth_arg = "-i '${cli_ssh_keyfile}' -ssh -user '${cli_username}'"
  } elsif !empty($cli_username) {
    # Username / Password auth (needed for AD and other Auth Realms)
    if !empty($cli_password) {
      $_cli_auth_arg = "-auth '${cli_username}:${cli_password}'"
    } elsif !empty($cli_password_file) {
      $_cli_auth_arg = "-auth '@${cli_password_file}'"
    } else {
      fail('ERROR: Need cli_password or cli_password_file if cli_username is specified')
    }
  } else {
    # default = no auth
    $_cli_auth_arg = undef
  }

  $plugin_dir = "${localstatedir}/plugins"
  $job_dir = "${localstatedir}/jobs"

  # lint:ignore:anchor_resource
  anchor {'jenkins::begin':}
  anchor {'jenkins::end':}
  # lint:endignore

  if $install_java {
    include java
  }

  if $direct_download {
    $repo_ = false
    $jenkins_package_class = 'jenkins::direct_download'
  } else {
    $jenkins_package_class = 'jenkins::package'
    if $repo {
      $repo_ = true
      include jenkins::repo
    } else {
      $repo_ = false
    }
  }
  include $jenkins_package_class

  include jenkins::user_setup
  include jenkins::config
  include jenkins::plugins
  include jenkins::jobs
  include jenkins::users
  include jenkins::proxy

  if $manage_service {
    include jenkins::service
    if empty($default_plugins){
      notice(sprintf('INFO: make sure you install the following plugins with your code using this module: %s',join($jenkins::params::default_plugins,','))) # lint:ignore:140chars
    }

    if $service_provider == 'systemd' {
      jenkins::systemd { 'jenkins':
        user   => $user,
        libdir => $libdir,
      }

      # jenkins::config manages the jenkins user resource, which is autorequired
      # by the file resource for the run wrapper.
      Class['jenkins::config']
        -> Jenkins::Systemd['jenkins']
          -> Anchor['jenkins::end']
    }
  }

  if defined('::firewall') and $configure_firewall {
    include jenkins::firewall
  }

  if $cli {
    include jenkins::cli
    include jenkins::cli_helper
  }

  if $executors {
    jenkins::cli::exec { 'set_num_executors':
      command => ['set_num_executors', $executors],
      unless  => "[ \$(\$HELPER_CMD get_num_executors) -eq ${executors} ]",
    }

    Class['jenkins::cli']
      -> Jenkins::Cli::Exec['set_num_executors']
        -> Class['jenkins::jobs']
  }

  if ($slaveagentport != undef) {
    jenkins::cli::exec { 'set_slaveagent_port':
      command => ['set_slaveagent_port', $slaveagentport],
      unless  => "[ \$(\$HELPER_CMD get_slaveagent_port) -eq ${slaveagentport} ]",
    }

    Class['jenkins::cli']
      -> Jenkins::Cli::Exec['set_slaveagent_port']
        -> Class['jenkins::jobs']
  }

  if $manage_service {
    Anchor['jenkins::begin']
    -> Class['jenkins::user_setup']
      -> Class[$jenkins_package_class]
        -> Class['jenkins::config']
          -> Class['jenkins::plugins']
            ~> Class['jenkins::service']
              -> Class['jenkins::jobs']
                -> Anchor['jenkins::end']
  }

  if $install_java {
    Anchor['jenkins::begin']
      -> Class['java']
        -> Class[$jenkins_package_class]
          -> Anchor['jenkins::end']
  }

  if $repo_ {
    Anchor['jenkins::begin']
      -> Class['jenkins::repo']
        -> Class['jenkins::package']
          -> Anchor['jenkins::end']
  }

  if ($configure_firewall and $manage_service) {
    Class['jenkins::service']
      -> Class['jenkins::firewall']
        -> Anchor['jenkins::end']
  }
}
# vim: ts=2 et sw=2 autoindent
