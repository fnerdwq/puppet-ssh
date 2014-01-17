# set flavor specific variables
class ssh::client::params {

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
