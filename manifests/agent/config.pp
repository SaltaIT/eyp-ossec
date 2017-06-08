class ossec::agent::config inherits ossec::agent {

  file { '/var/ossec/etc/ossec-agent.conf':
    ensure  => 'present',
    owner   => 'ossec',
    group   => 'ossec',
    mode    => '0644',
    content => template("${module_name}/agent/agentconf.erb"),
  }

  # [root@elk ~]# /var/ossec/bin/ossec-control start
  # Starting OSSEC HIDS 2.9.0 (by Trend Micro Inc.)...
  # ossec-execd already running...
  # 2017/06/08 11:00:08 ossec-agentd: INFO: Using notify time: 600 and max time to reconnect: 1800
  # 2017/06/08 11:00:08 ossec-agentd(1402): ERROR: Authentication key file '/var/ossec/etc/client.keys' not found.
  # 2017/06/08 11:00:08 ossec-agentd(1750): ERROR: No remote connection configured. Exiting.
  # 2017/06/08 11:00:08 ossec-agentd(4109): ERROR: Unable to start without auth keys. Exiting.
  # ossec-agentd did not start
  # [root@elk ~]#  /var/ossec/bin/agent-auth -m 192.168.56.103 -p 1515
  # 2017/06/08 11:03:57 ossec-authd: INFO: Started (pid: 2031).
  # 2017/06/08 11:03:57 INFO: Connected to 192.168.56.103 at address 192.168.56.103, port 1515
  # INFO: Connected to 192.168.56.103:1515
  # INFO: Using agent name as: elk.vm
  # INFO: Send request to manager. Waiting for reply.
  # INFO: Received response with agent key
  # INFO: Valid key created. Finished.
  # INFO: Connection closed.
  # [root@elk ~]# ls -la /var/ossec/etc/client.keys
  # -rw-r--r-- 1 root ossec 81 Jun  8 11:03 /var/ossec/etc/client.keys

  exec { 'agent key':
    command => "/var/ossec/bin/agent-auth -m ${ossec::agent::server} -p ${ossec::agent::authd_port}",
    creates => '/var/ossec/etc/client.keys',
    path    => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  systemd::sysvwrapper { 'ossec-hids':
    initscript => '/var/ossec/bin/ossec-control',
  }

}
