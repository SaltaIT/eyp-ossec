class ossec::server::install inherits ossec::server {

  include ::art
  include ::epel

  if($ossec::server::manage_package)
  {
    package { $ossec::params::server_package_name:
      ensure => $ossec::server::package_ensure,
    }
  }

  # if [ ! -e $HOME/etc/sslmanager.key ]
  #   then
  #     echo "Creating ossec-authd key and cert"
  #     openssl genrsa -out $HOME/etc/sslmanager.key 4096
  #     openssl req -new -x509 -key $HOME/etc/sslmanager.key\
  #       -out $HOME/etc/sslmanager.cert -days 3650\
  #       -subj /CN=fqdn/
  # fi

}
