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
# 14 global
# 15 remote
# 16 alerts
# 17 <command>
# 18 <active-response>
# 19 <localfile>
# 99 end
#
class ossec::server::config inherits ossec::server {

  if(defined(Class['::selinux']))
  {
    $current_selinux_mode = $::selinux? {
      bool2boolstr(false) => 'disabled',
      false               => 'disabled',
      default             => $::selinux_current_mode,
    }

    case $current_selinux_mode
    {
      /^(enforcing|permissive)$/:
      {
        exec { 'logrotate_ossec_server selinux dir':
          command => "mkdir -p ${ossec::server::selinux_dir}",
          creates => $ossec::server::selinux_dir,
          path    => '/bin:/sbin:/usr/bin:/usr/sbin',
        }

        file { "${ossec::server::selinux_dir}/logrotate_ossec_server.te":
          ensure  => 'present',
          owner   => 'root',
          group   => 'root',
          mode    => '0400',
          content => template("${module_name}/ossec-server/selinux/policy.erb"),
          require => Exec['logrotate_ossec_server selinux dir'],
        }

        selinux::semodule { 'logrotate_ossec_server':
          basedir => $ossec::server::selinux_dir,
          require => File["${ossec::server::selinux_dir}/logrotate_ossec_server.te"],
        }
      }
      'disabled': { }
      default: { fail('this should not happen') }
    }
  }

  file { '/var/ossec/etc/shared/ar.conf':
    ensure  => 'present',
    owner   => 'ossec',
    group   => 'ossec',
    mode    => '0440',
    content => template("${module_name}/arconf.erb"),
  }

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

  concat::fragment{ "server global start":
    target  => '/var/ossec/etc/ossec-server.conf',
    order   => "14a",
    content => "\n  <global>\n",
  }

  concat::fragment{ "server global whitelist":
    target  => '/var/ossec/etc/ossec-server.conf',
    order   => "14b",
    content => template("${module_name}/ossec-server/14b_whitelist.erb"),
  }

  concat::fragment{ "server global end":
    target  => '/var/ossec/etc/ossec-server.conf',
    order   => "14z",
    content => "\n  </global>\n",
  }

  concat::fragment{ "server remote":
    target  => '/var/ossec/etc/ossec-server.conf',
    order   => "15",
    content => template("${module_name}/ossec-server/15_remote.erb"),
  }

  concat::fragment{ "server alerts":
    target  => '/var/ossec/etc/ossec-server.conf',
    order   => "16",
    content => template("${module_name}/ossec-server/16_alerts.erb"),
  }

  if ($ossec::server::add_default_commands)
  {
    # 17 <command>
    concat::fragment{ "command alerts":
      target  => '/var/ossec/etc/ossec-server.conf',
      order   => "17",
      content => template("${module_name}/ossec-server/17_default_commands.erb"),
    }
  }

  if ($ossec::server::add_default_activeresponses)
  {
    # 18 <activeresponse>
    concat::fragment{ "activeresponse alerts":
      target  => '/var/ossec/etc/ossec-server.conf',
      order   => "18",
      content => template("${module_name}/ossec-server/18_default_activeresponse.erb"),
    }
  }

  if ($ossec::server::add_default_localfiles)
  {
    # 19 <localfile>
    concat::fragment{ "localfile alerts":
      target  => '/var/ossec/etc/ossec-server.conf',
      order   => "19",
      content => template("${module_name}/ossec-server/19_default_localfile.erb"),
    }
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
    initscript           => '/var/ossec/bin/ossec-control',
    wait_time_on_startup => '5s',
  }

}
