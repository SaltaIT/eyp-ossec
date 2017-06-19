class ossec::agent(
                    $manage_package        = true,
                    $package_ensure        = 'installed',
                    $manage_service        = true,
                    $manage_docker_service = true,
                    $service_ensure        = 'running',
                    $service_enable        = true,
                    $server                = '127.0.0.1',
                    $authd_port            = '1515',
                    $ossec_profile         = undef,
                    $selinux_dir           = '/usr/local/src/selinux/ossec_agent',
                  ) inherits ossec::params{

  validate_re($package_ensure, [ '^present$', '^installed$', '^absent$', '^purged$', '^held$', '^latest$' ], 'Not a supported package_ensure: present/absent/purged/held/latest')

  class { '::ossec::agent::install': }
  -> class { '::ossec::agent::config': }
  ~> class { '::ossec::agent::service': }
  -> Class['::ossec::agent']

}
