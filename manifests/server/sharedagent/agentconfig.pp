# http://ossec-docs.readthedocs.io/en/latest/manual/syscheck/
define ossec::server::sharedagent::directories(
                                                $os                 = 'Linux',
                                                $syscheck_frequency = '79200',
                                              ) {
  concat::fragment{ "shared agent ${os} header":
    target  => '/var/ossec/etc/shared/agent.conf',
    order   => "${os}1",
    content => template("${module_name}/shared_agent/01_agentconfig.erb"),
  }

  #  </syscheck>
  concat::fragment{ "shared agent ${os} syscheck end":
    target  => '/var/ossec/etc/shared/agent.conf',
    order   => "${os}3",
    content => "  </syscheck>\n",
  }

  concat::fragment{ "shared agent ${os} agent_config end":
    target  => '/var/ossec/etc/shared/agent.conf',
    order   => "${os}3",
    content => "</agent_config>\n",
  }

}
