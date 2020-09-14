# Class: jenkins::sysconfig
#
define jenkins::sysconfig(
  String $value,
) {

  if ($value =~ /\$/) {
    warning("Jenkins::Sysconfig[${name}]: detected \'\$\' in value -- be advised the variable interpolation will not work under systemd")
  }

  if $jenkins::manage_service and $jenkins::service_restart {
    $notify = Class['::jenkins::service']
  } else {
    $notify = undef
  }
  file_line { "Jenkins sysconfig setting ${name}":
    path   => "${jenkins::sysconfdir}/jenkins",
    line   => "${name}=\"${value}\"",
    match  => "^${name}=",
    notify => $notify,
  }
}
