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
                                                $directories,
                                                $realtime       = true,
                                                $report_changes = true,
                                                $restrict       = undef,
                                                $check_size     = true,
                                                $check_sha1sum  = true,
                                                $check_md5sum   = true,
                                                $check_owner    = true,
                                                $check_group    = true,
                                                $check_perm     = true,
                                                $os             = $name,
                                              ) {
  #    <!-- Directories to check  (perform all possible verifications) -->
  if(!defined(Concat::Fragment["shared agent ${os} directories header"]))
  {
    concat::fragment{ "shared agent ${os} directories header":
      target  => '/var/ossec/etc/shared/agent.conf',
      order   => "${os}20",
      content => "\n    <!-- Directories to check  (perform all possible verifications) -->\n\n",
    }
  }

  concat::fragment{ "shared agent ${os} directories ${directories}":
    target  => '/var/ossec/etc/shared/agent.conf',
    order   => "${os}21",
    content => template("${module_name}/shared_agent/02_directories.erb"),
  }

}
