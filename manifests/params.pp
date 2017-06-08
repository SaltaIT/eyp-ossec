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
        /^[5-7].*$/:
        {
        }
        default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
      }
    }
    'Debian':
    {
      case $::operatingsystem
      {
        'Ubuntu':
        {
          case $::operatingsystemrelease
          {
            /^14.*$/:
            {
            }
            /^16.*$/:
            {
            }
            default: { fail("Unsupported Ubuntu version! - ${::operatingsystemrelease}")  }
          }
        }
        'Debian': { fail('Unsupported')  }
        default: { fail('Unsupported Debian flavour!')  }
      }
    }
    default: { fail('Unsupported OS!')  }
  }
}
