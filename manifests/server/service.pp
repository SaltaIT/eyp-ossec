class ossec::server::service inherits ossec::server {

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $ossec::server::manage_docker_service)
  {
    if($ossec::server::manage_service)
    {
      service { $ossec::params::server_service_name_authd:
        ensure => $ossec::server::authd_service_ensure,
        enable => $ossec::server::authd_service_enable,
      }

      ->
      # we need to register at least one client to be able to start ossec-hids
      service { $ossec::params::server_service_name:
        ensure => $ossec::server::service_ensure,
        enable => $ossec::server::service_enable,
      }
    }
  }
}
