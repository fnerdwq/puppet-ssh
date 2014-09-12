# set flavor specific variables (private)
class ssh::client::params {

  $manage_known_hosts = true

  case $::osfamily {
    'Debian': {
      $package = 'openssh-client'
    }
    'RedHat': {
      $package = 'openssh-clients'
    }
    default:  {
      fail("Module ${module_name} is not supported on ${::operatingsystem}/${::osfamily}")
    }
  }
}
