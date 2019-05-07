class ossec::params {

  # /etc/rc.d/init.d/ossec-hids
  # /etc/rc.d/init.d/ossec-hids-authd

  $server_package_name=[ 'ossec-hids', 'ossec-hids-server' ]
  $server_service_name_authd='ossec-hids-authd'
  $server_service_name='ossec-hids'

  $agent_package_name=[ 'ossec-hids-agent' ]
  $agent_service_name='ossec-hids'

  case $::osfamily
  {
    'redhat':
    {
      case $::operatingsystemrelease
      {
        /^[7].*$/:
        {
        }
        default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
      }
    }
    default: { fail('Unsupported OS!')  }
  }
}
