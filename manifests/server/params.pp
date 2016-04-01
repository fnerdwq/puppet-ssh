# set flavor specific variables (private)
class ssh::server::params {

  $port                   = 22
  $pubkeyAuthentication   = 'yes'
  $passwordAuthentication = 'yes'
  $permitRootLogin        = 'yes'
  $useDns                 = 'yes'
  $clientAliveInterval    = 0
  $strictModes            = 'yes'
  $maxAuthTries           = 6
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
      $selinux_policy = false
      $sftp_server = '/usr/lib/openssh/sftp-server'
      $printMotd = 'no'
      $syslogFacility = 'AUTH'


      if versioncmp($::operatingsystemmajrelease, '8') >=0 {
        $ssh_host_ed25519_key   = true
        $usePrivilegeSeparation = 'sandbox'
      } else {
        $ssh_host_ed25519_key   = false
        $usePrivilegeSeparation = 'yes'
      }
    }
    'RedHat': {
      $service = 'sshd'
      $selinux_policy = true
      $sftp_server = '/usr/libexec/openssh/sftp-server'
      $printMotd = 'yes'
      $syslogFacility = 'AUTHPRIV'

      if versioncmp($::operatingsystemmajrelease, '7') >=0 {
        $ssh_host_ed25519_key   = true
        $usePrivilegeSeparation = 'sandbox'
      } else {
        $ssh_host_ed25519_key   = false
        $usePrivilegeSeparation = 'yes'
      }
    }
    default:  {
      fail("Module ${module_name} is not supported on ${::operatingsystem}/${::osfamily}")
    }
  }
}
