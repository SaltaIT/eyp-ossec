#
#    <ignore>/etc/mtab</ignore>
#
define ossec::server::ignore(
                              $file,
                              $os = $name,
                            ) {
  #    <!-- Files/directories to ignore -->
  if(!defined(Concat::Fragment["server ${os} ignore header"]))
  {
    concat::fragment{ "server ${os} ignore header":
      target  => '/var/ossec/etc/shared/agent.conf',
      order   => "11a",
      content => "\n    <!-- Files/directories to ignore -->\n",
    }
  }

  concat::fragment{ "server ${os} ignore ${file}":
    target  => '/var/ossec/etc/shared/agent.conf',
    order   => "11b",
    content => template("${module_name}/shared_agent/03_ignore.erb"),
  }
}
