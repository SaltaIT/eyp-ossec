#
# <directories {% if directory.check_all is defined %}check_all="{{ directory.check_all }}"{% endif %}
#         {% if directory.realtime is defined %}realtime="{{ directory.realtime }}"{% endif %}
#         {% if directory.report_changes is defined %}report_changes="{{ directory.report_changes }}"{% endif %}
#         {% if directory.restrict is defined %}restrict="{{ directory.restrict }}"{% endif %}
#         {% if directory.check_size is defined %}check_size="{{ directory.check_size }}"{% endif %}
#         {% if directory.check_sum is defined %}check_sum="{{ directory.check_sum }}"{% endif %}
#         >{{ directory.dirs }}</directories>
#
define ossec::server::sharedagent::directories(
                                                $check_all      = undef,
                                                $realtime       = undef,
                                                $report_changes = undef,
                                                $restrict       = undef,
                                                $check_size     = undef,
                                                $check_sum      = undef,
                                                $os             = 'Linux',
                                              ) {
  #    <!-- Directories to check  (perform all possible verifications) -->

}
