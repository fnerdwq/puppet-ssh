# set flavor specific variables
class ssh::server::params {

  $package = 'openssh-server'

  case $::osfamily {
    'Debian': {
      $service = 'ssh'
      $sftp_server = '/usr/lib/openssh/sftp-server'
      $printMotd = 'no'
      $syslogFacility = 'AUTH'
    }
    'RedHat': {
      $service = 'sshd'
      $sftp_server = '/usr/libexec/openssh/sftp-server'
      $printMotd = 'yes'
      $syslogFacility = 'AUTHPRIV'
    }
    default:  {
      fail("Module ${module_name} is not supported on ${::operatingsystem}/${::osfamily}")
    }
  }
}
