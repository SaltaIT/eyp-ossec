#
# puppet2sitepp @ossecserversyslogoutputs
#
define ossec::server::syslogoutput(
                                    $syslog_server = $name,
                                    $level         = undef,
                                    $format        = undef, # @param format Allowed default, cef, splunk, json (default: undef)
                                    $port          = '514',
                                  ) {
  # ossec-server/20_syslog_output.erb
  concat::fragment{ "server syslog ${syslog_server}":
    target  => '/var/ossec/etc/ossec-server.conf',
    order   => '20',
    content => template("${module_name}/ossec-server/20_syslog_output.erb"),
  }

  #/var/ossec/bin/ossec-control enable client-syslog
  if(!defined(Exec['enable client-syslog']))
  {
    exec { 'enable client-syslog':
      command => '/var/ossec/bin/ossec-control enable client-syslog',
      before  => Class['::ossec::server::service'],
      require => Concat['/var/ossec/etc/ossec-server.conf'],
      unless  => '/var/ossec/bin/ossec-control status | grep csyslog',
    }
  }
}
