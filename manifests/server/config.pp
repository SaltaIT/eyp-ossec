# concat /var/ossec/etc/shared/agent.conf
# 0 header
# <os>1 agent config
# <os>2 directories
# <os>3 ignores
# <os>4 syscheck end
# <os>5 localfile
# <os>6 rootcheck
# <os>9 agent_config end
#
#
# concat local_rules.xml
# 0 header
#
class ossec::server::config inherits ossec::server {

  #/var/ossec/etc/shared/agent.conf
  concat { '/var/ossec/etc/shared/agent.conf':
    ensure  => 'present',
    owner   => 'ossec',
    group   => 'ossec',
    mode    => '0644',
  }

  concat::fragment{ '/var/ossec/etc/shared/agent.conf header':
    target  => '/var/ossec/etc/shared/agent.conf',
    order   => '0',
    content => template("${module_name}/shared_agent/00_header.erb"),
  }

  concat { '/var/ossec/rules/local_rules.xml':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  concat::fragment{ '/var/ossec/rules/local_rules.xml header':
    target  => '/var/ossec/rules/local_rules.xml',
    order   => '0',
    content => template("${module_name}/localrules/00_header.erb"),
  }

  #/var/ossec/etc/ossec-server.conf

  # systemd
  systemd::service { 'ossec-hids-authd':
    execstart => "/var/ossec/bin/ossec-authd -p ${ossec::server::authd_port} 2>&1 >> /var/ossec/logs/ossec-authd.log",
  }

}
