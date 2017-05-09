class ossec::service inherits ossec {

  #
  validate_bool($ossec::manage_docker_service)
  validate_bool($ossec::manage_service)
  validate_bool($ossec::service_enable)

  validate_re($ossec::service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${ossec::service_ensure}")

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $ossec::manage_docker_service)
  {
    if($ossec::manage_service)
    {
      service { $ossec::params::service_name:
        ensure => $ossec::service_ensure,
        enable => $ossec::service_enable,
      }
    }
  }
}
