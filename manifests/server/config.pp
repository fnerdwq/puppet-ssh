# configure ssh server and make hostkey available
class ssh::server::config {

  file { '/etc/ssh/sshd_config':
    ensure  => present,
    mode    => '0644',
    owner   => root,
    group   => root,
    content => template('ssh/sshd_config.erb'),
  }

  # collect all ipadresses as alias for the host keys
  $ipaddresses = ipaddresses()
  $host_aliases = flatten([ $::fqdn, $::hostname, $ipaddresses ])

  @@sshkey { "${::fqdn}_dsa":
    host_aliases => $host_aliases,
    type         => dsa,
    key          => $::sshdsakey,
  }
  @@sshkey { "${::fqdn}_rsa":
    host_aliases => $host_aliases,
    type         => rsa,
    key          => $::sshrsakey,
  }
  if $::sshecdsakey {
    @@sshkey { "${::fqdn}_ecdsa":
      host_aliases => $host_aliases,
      type         => 'ecdsa-sha2-nistp256',
      key          => $::sshecdsakey,
    }
  }


}
