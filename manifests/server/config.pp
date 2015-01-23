# configure ssh server (private)
class ssh::server::config {

  $port                   = $ssh::server::port
  $pubkeyAuthentication   = $ssh::server::pubkeyAuthentication
  $passwordAuthentication = $ssh::server::passwordAuthentication
  $permitRootLogin        = $ssh::server::permitRootLogin
  $host_aliases           = $ssh::server::host_aliases
  $kexAlgorithms          = $ssh::server::kexAlgorithms
  $ciphers                = $ssh::server::ciphers
  $macs                   = $ssh::server::macs

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
}
