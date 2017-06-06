#
#  <!-- Files to monitor (localfiles) -->
#  <localfile>
#    <log_format>syslog</log_format>
#    <location>/var/log/messages</location>
#  </localfile>
#
# {% if item.localfiles is defined %}
#   <!-- Files to monitor (localfiles) -->
# {% for localfile in item.localfiles %}
#   <localfile>
#      <log_format>{{ localfile.format }}</log_format>
#      {% if localfile.command is defined %}
#      <command>{{ localfile.command }}</command>
#      {% else %}
#      <location>{{ localfile.location }}</location>
#      {% endif %}
#   </localfile>
# {% endfor %}
# {% endif %}
#
#
define ossec::server::sharedagent::localfile(
                                              $logformat,
                                              $location = undef,
                                              $command  = undef,
                                              $os       = $name,
                                            ) {
  #  <!-- Files to monitor (localfiles) -->
  if(!defined(Concat::Fragment["shared agent ${os} localfile header"]))
  {
    concat::fragment{ "shared agent ${os} localfile header":
      target  => '/var/ossec/etc/shared/agent.conf',
      order   => "${os}50",
      content => "\n  <!-- Files to monitor (localfiles) -->\n",
    }
  }

  concat::fragment{ "shared agent ${os} localfile ${location} ${command} ${logformat}":
    target  => '/var/ossec/etc/shared/agent.conf',
    order   => "${os}51",
    content => template("${module_name}/shared_agent/05_localfile.erb"),
  }
}
