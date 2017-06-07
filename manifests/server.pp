class ossec::server(
                      $manage_package        = true,
                      $package_ensure        = 'installed',
                      $manage_service        = true,
                      $manage_docker_service = true,
                      $service_ensure        = 'running',
                      $service_enable        = true,
                      $authd_port            = '1515',
                      $email_notification    = true,
                      $email_from            = 'ossec@systemadmin.es',
                      $email_to              = [ 'ossecdemo@systemadmin.es' ],
                      $smtp_server           = '127.0.0.1',
                      $syscheck_frequency    = '79200',
                    ) inherits ossec::params{

  validate_re($package_ensure, [ '^present$', '^installed$', '^absent$', '^purged$', '^held$', '^latest$' ], 'Not a supported package_ensure: present/absent/purged/held/latest')

  class { '::ossec::server::install': }
  -> class { '::ossec::server::config': }
  ~> class { '::ossec::server::service': }
  -> Class['::ossec::server']

}
