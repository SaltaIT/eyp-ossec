# concat /var/ossec/etc/shared/agent.conf
#
# 0 header
# 1 agent config
# 1 directories
# 2 ignores
# 3 syscheck end
class ossec::server::config inherits ossec::server {

  #/var/ossec/etc/shared/agent.conf
  concat { '/var/ossec/etc/shared/agent.conf':
    ensure  => 'present',
    owner   => 'ossec',
    group   => 'ossec',
    mode    => '0640',
  }

  concat::fragment{ '/var/ossec/etc/shared/agent.conf header':
    target  => '/var/ossec/etc/shared/agent.conf',
    order   => '0',
    content => template("${module_name}/shared_agent/00_sharedagent_header.erb"),
  }

  #  </syscheck>
  concat::fragment{ '/var/ossec/etc/shared/agent.conf syscheck end':
    target  => '/var/ossec/etc/shared/agent.conf',
    order   => '3',
    content => "  </syscheck>\n",
  }

}
