# install the openssh client package (private)
class ssh::client::install {

  package { 'ssh-client':
    ensure => latest,
    name   => $ssh::client::params::package,
  }

}
