class ossec::agent::service inherits ossec::agent {

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $ossec::agent::manage_docker_service)
  {
    if($ossec::agent::manage_service)
    {
      service { $ossec::params::agent_service_name:
        ensure => $ossec::agent::service_ensure,
        enable => $ossec::agent::service_enable,
      }
    }
  }
}
