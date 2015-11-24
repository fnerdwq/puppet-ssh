# make ssh host keys availabe (private)
class ssh::server::sshkeys {

  # collect all ipadresses as alias for the host keys
  $ipaddresses = ipaddresses()
  $host_aliases = flatten([ $::fqdn, $::hostname, $ipaddresses, $ssh::server::host_aliases ])

  # ensure insecure hostfiles removed
  file { ['/etc/ssh/ssh_host_key', '/etc/ssh/ssh_host_dsa_key']:
    ensure => absent,
  }

  if $::sshrsakey {
    @@sshkey { "${::fqdn}_rsa":
      host_aliases => $host_aliases,
      type         => rsa,
      key          => $::sshrsakey,
    }
  }
  if $::sshecdsakey {
    @@sshkey { "${::fqdn}_ecdsa":
      host_aliases => $host_aliases,
      type         => 'ecdsa-sha2-nistp256',
      key          => $::sshecdsakey,
    }
  }

  if $::sshed25519key {
    @@sshkey { "${::fqdn}_ed25519":
      host_aliases => $host_aliases,
      type         => 'ssh-ed25519',
      key          => $::sshed25519key,
    }
  }

}
