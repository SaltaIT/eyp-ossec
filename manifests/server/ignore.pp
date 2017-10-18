#
#    <ignore>/etc/mtab</ignore>
#
define ossec::server::ignore(
                              $file,
                            ) {
  #    <!-- Files/directories to ignore -->
  if(!defined(Concat::Fragment['server ignore header']))
  {
    concat::fragment{ 'server ignore header':
      target  => '/var/ossec/etc/ossec-server.conf',
      order   => '11a',
      content => "\n    <!-- Files/directories to ignore -->\n",
    }
  }

  concat::fragment{ "server ignore ${file}":
    target  => '/var/ossec/etc/ossec-server.conf',
    order   => '11b',
    content => template("${module_name}/shared_agent/03_ignore.erb"),
  }
}
