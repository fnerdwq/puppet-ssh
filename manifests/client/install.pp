# install the openssh client package
class ssh::client::install {

  package { 'ssh-client':
    ensure => latest,
    name   => $ssh::client::params::package,
  }

}
