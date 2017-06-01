class ossec::server::install inherits ossec::server {

  include ::art
  include ::epel

  if($ossec::server::manage_package)
  {
    package { $ossec::params::server_package_name:
      ensure => $ossec::server::package_ensure,
    }
  }

}
