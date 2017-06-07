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
#
# concat /var/ossec/etc/ossec-server.conf
# 00 header
# 01 global
# 02 <email_alerts>
# 03 email entries
# 04 </email_alerts>
# 05 <rules>
# 06 rules entries
# 07 </rules>
# 08 <syscheck>
# 09 frequency
# 10 directories
# 11 igonore
# 12 </syscheck>
# 13 rootcheck
# 99 end
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

  # /var/ossec/etc/ossec-server.conf
  concat { '/var/ossec/etc/ossec-server.conf':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  concat::fragment{ '/var/ossec/etc/ossec-server.conf header':
    target  => '/var/ossec/etc/ossec-server.conf',
    order   => '00',
    content => template("${module_name}/ossec-server/00_header.erb"),
  }

  concat::fragment{ '/var/ossec/etc/ossec-server.conf global':
    target  => '/var/ossec/etc/ossec-server.conf',
    order   => '01',
    content => template("${module_name}/ossec-server/01_global.erb"),
  }

  concat::fragment{ '/var/ossec/etc/ossec-server.conf rules':
    target  => '/var/ossec/etc/ossec-server.conf',
    order   => '06',
    content => template("${module_name}/ossec-server/06_rules.erb"),
  }

  concat::fragment{ "server syscheck header":
    target  => '/var/ossec/etc/ossec-server.conf',
    order   => "08",
    content => "\n  <syscheck>\n",
  }

  concat::fragment{ "server syscheck frequency":
    target  => '/var/ossec/etc/ossec-server.conf',
    order   => "09",
    content => "    <frequency>${syscheck_frequency}</frequency>\n",
  }

  concat::fragment{ "server syscheck end":
    target  => '/var/ossec/etc/ossec-server.conf',
    order   => "12",
    content => "\n  </syscheck>\n",
  }

  concat::fragment{ "server rootcheck":
    target  => '/var/ossec/etc/ossec-server.conf',
    order   => "13",
    content => template("${module_name}/ossec-server/13_rootcheck.erb"),
  }

  concat::fragment{ '/var/ossec/etc/ossec-server.conf tail':
    target  => '/var/ossec/etc/ossec-server.conf',
    order   => '99',
    content => template("${module_name}/ossec-server/99_end.erb"),
  }



  # systemd
  systemd::service { 'ossec-hids-authd':
    execstart => "/var/ossec/bin/ossec-authd -p ${ossec::server::authd_port} 2>&1 >> /var/ossec/logs/ossec-authd.log",
  }

  systemd::sysvwrapper { 'ossec-hids':
    initscript => '/var/ossec/bin/ossec-control',
  }

}
