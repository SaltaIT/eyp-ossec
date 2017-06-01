#
#    <ignore>/etc/mtab</ignore>
#
define ossec::server::sharedagent::ignore (
                                            $file,
                                            $os = $name,
                                          ) {
  #    <!-- Files/directories to ignore -->
  if(!defined(Concat::Fragment["shared agent ${os} directories header"]))
  {
    concat::fragment{ "shared agent ${os} ignore header":
      target  => '/var/ossec/etc/shared/agent.conf',
      order   => "${os}30",
      content => "\n    <!-- Files/directories to ignore -->\n",
    }
  }

  concat::fragment{ "shared agent ${os} ignore ${file}":
    target  => '/var/ossec/etc/shared/agent.conf',
    order   => "${os}31",
    content => template("${module_name}/shared_agent/03_ignore.erb"),
  }
}
