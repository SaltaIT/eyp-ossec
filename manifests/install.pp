class ossec::install inherits ossec {

  if($ossec::manage_package)
  {
    package { $ossec::params::package_name:
      ensure => $ossec::package_ensure,
    }
  }

}
