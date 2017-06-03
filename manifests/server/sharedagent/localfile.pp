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
                                              $location,
                                              $logformat = undef,
                                              $command   = undef,
                                              $os        = $name,
                                            ) {
}
