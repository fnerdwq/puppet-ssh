# set flavor specific variables (private)
class ssh::server::params {

  $port                   = 22
  $pubkeyAuthentication   = 'yes'
  $passwordAuthentication = 'yes'
  $permitRootLogin        = 'yes'
  $kexAlgorithms          = undef
  $ciphers                = undef
  $macs                   = undef
  $secure_moduli          = false

  $export_host_keys       = true
  $host_aliases           = []

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
