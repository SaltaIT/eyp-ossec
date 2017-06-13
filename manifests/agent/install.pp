class ossec::agent::install inherits ossec::agent {

  include ::art
  include ::epel

  if($ossec::agent::manage_package)
  {
    package { $ossec::params::agent_package_name:
      ensure  => $ossec::agent::package_ensure,
      require => Class[ [ '::art', '::epel' ] ],
    }
  }

}
