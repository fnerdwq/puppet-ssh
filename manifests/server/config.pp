# configure ssh server (private)
class ssh::server::config {

  $port                   = $ssh::server::port
  $pubkeyAuthentication   = $ssh::server::pubkeyAuthentication
  $passwordAuthentication = $ssh::server::passwordAuthentication
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

}
