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
                      $rootcheck_system_audit    = [
                                          '/var/ossec/etc/shared/system_audit_rcl.txt',
                                          '/var/ossec/etc/shared/cis_debian_linux_rcl.txt',
                                          '/var/ossec/etc/shared/cis_rhel_linux_rcl.txt',
                                          '/var/ossec/etc/shared/cis_rhel7_linux_rcl.txt',
                                          ],
                      $rootcheck_rootkit_trojans = '/var/ossec/etc/shared/rootkit_trojans.txt',
                      $rootcheck_rootkit_files   = '/var/ossec/etc/shared/rootkit_files.txt',
                      $remote_connection = 'syslog',
                      $remote_allowed_ips = [ '0.0.0.0' ],
                      $global_whitelist = [ $::ipaddress ],
                    ) inherits ossec::params{

  validate_re($package_ensure, [ '^present$', '^installed$', '^absent$', '^purged$', '^held$', '^latest$' ], 'Not a supported package_ensure: present/absent/purged/held/latest')

  class { '::ossec::server::install': }
  -> class { '::ossec::server::config': }
  ~> class { '::ossec::server::service': }
  -> Class['::ossec::server']

}
