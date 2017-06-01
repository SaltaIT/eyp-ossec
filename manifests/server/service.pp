class ossec::server::service inherits ossec::server {

  #
  validate_bool($ossec::server::manage_docker_service)
  validate_bool($ossec::server::manage_service)
  validate_bool($ossec::server::service_enable)

  validate_re($ossec::server::service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${ossec::service_ensure}")

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $ossec::server::manage_docker_service)
  {
    if($ossec::server::manage_service)
    {
      service { $ossec::params::server_service_name:
        ensure => $ossec::server::service_ensure,
        enable => $ossec::server::service_enable,
      }
    }
  }
}
