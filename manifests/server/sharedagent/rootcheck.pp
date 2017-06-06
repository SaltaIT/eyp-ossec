#
# <rootcheck>
#   <rootkit_files>/var/ossec/etc/shared/rootkit_files.txt</rootkit_files>
#   <rootkit_trojans>/var/ossec/etc/shared/rootkit_trojans.txt</rootkit_trojans>
#   <system_audit>/var/ossec/etc/shared/system_audit_rcl.txt</system_audit>
#   {% if item.cis_distribution_filename is defined %}
#   <system_audit>/var/ossec/etc/shared/{{ item.cis_distribution_filename }}</system_audit>
#   {% else %}
#   {# none specified so install all #}
#   <system_audit>/var/ossec/etc/shared/cis_debian_linux_rcl.txt</system_audit>
#   <system_audit>/var/ossec/etc/shared/cis_rhel_linux_rcl.txt</system_audit>
#   <system_audit>/var/ossec/etc/shared/cis_rhel5_linux_rcl.txt</system_audit>
#   {% endif %}
# </rootcheck>
#
define ossec::server::sharedagent::localfile(
                                              $os              = $name,
                                              $system_audit    = [
                                                                  '/var/ossec/etc/shared/system_audit_rcl.txt',
                                                                  '/var/ossec/etc/shared/cis_debian_linux_rcl.txt',
                                                                  '/var/ossec/etc/shared/cis_rhel_linux_rcl.txt',
                                                                  '/var/ossec/etc/shared/cis_rhel7_linux_rcl.txt',
                                                                  ],
                                              $rootkit_trojans = '/var/ossec/etc/shared/rootkit_trojans.txt',
                                              $rootkit_files   = '/var/ossec/etc/shared/rootkit_files.txt',
                                            ) {
  #
  concat::fragment{ "shared agent ${os} rootcheck":
    target  => '/var/ossec/etc/shared/agent.conf',
    order   => "${os}61",
    content => template("${module_name}/shared_agent/06_rootcheck.erb"),
  }
}
