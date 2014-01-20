# install openssh server (private)
class ssh::server::install {

  package { 'ssh-server':
    ensure => latest,
    name   => $ssh::server::params::package,
  }

}
