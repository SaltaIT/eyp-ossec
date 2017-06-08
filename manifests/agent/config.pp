class ossec::agent::config inherits ossec::agent {

  file { '/var/ossec/etc/ossec-agent.conf':
    ensure  => 'present',
    owner   => 'ossec',
    group   => 'ossec',
    mode    => '0644',
    content => template("${module_name}/agent/agentconf.erb"),
  }
}
