# Class: jenkins::sysconfig
#
define jenkins::sysconfig(
  $value,
) {
  validate_string($value)

  $path = $::osfamily ? {
    'RedHat'  => '/etc/sysconfig',
    'Suse'    => '/etc/sysconfig',
    'Debian'  => '/etc/default',
    'OpenBSD' => undef,
    default   => fail( "Unsupported OSFamily ${::osfamily}" )
  }

  if $path {
    file_line { "Jenkins sysconfig setting ${name}":
      path   => "${path}/jenkins",
      line   => "${name}=\"${value}\"",
      match  => "^${name}=",
      notify => Service['jenkins'],
    }
  }

}
