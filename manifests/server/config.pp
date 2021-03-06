# configure ssh server (private)
class ssh::server::config {

  $port                   = $ssh::server::port
  $pubkeyAuthentication   = $ssh::server::pubkeyAuthentication
  $passwordAuthentication = $ssh::server::passwordAuthentication
  $permitRootLogin        = $ssh::server::permitRootLogin
  $useDns                 = $ssh::server::useDns
  $clientAliveInterval    = $ssh::server::clientAliveInterval
  $strictModes            = $ssh::server::strictModes
  $maxAuthTries           = $ssh::server::maxAuthTries
  $kexAlgorithms          = $ssh::server::kexAlgorithms
  $ciphers                = $ssh::server::ciphers
  $macs                   = $ssh::server::macs
  $sftp_server            = $ssh::server::sftp_server

  file { '/etc/ssh/sshd_config':
    ensure  => present,
    mode    => '0644',
    owner   => root,
    group   => root,
    content => template('ssh/sshd_config.erb'),
  }

  if $ssh::server::secure_moduli {
    exec { 'remove moduli <= 2000 bit':
      command => 'awk \'$5 > 2000\' /etc/ssh/moduli > /tmp/moduli && mv /tmp/moduli /etc/ssh/moduli',
      unless  => 'test $(awk \'$5 <= 2000\' /etc/ssh/moduli | wc -l) -eq 0',
      path    => [ '/bin', '/usr/bin' ],
    }
  }

  # set selinux policy for ssh port
  if $ssh::server::selinux_policy {
    ensure_packages('policycoreutils-python')
    exec { "semanage port policy for ssh_port_t: ${port}":
      command => "semanage port -a -t ssh_port_t -p tcp ${port}",
      unless  => "semanage port --list | egrep '^ssh_port_t\s*tcp\s*${port}'",
      path    => ['/sbin', '/usr/sbin', '/bin'],
      require => Package['policycoreutils-python'],
    }
  }

}
