# make ssh host keys availabe (private)
class ssh::server::sshkeys {

  # collect all ipadresses as alias for the host keys
  $ipaddresses = ipaddresses()
  $host_aliases = flatten([ $::fqdn, $::hostname, $ipaddresses, $ssh::server::host_aliases ])

  if $::sshdsakey {
    @@sshkey { "${::fqdn}_dsa":
      host_aliases => $host_aliases,
      type         => dsa,
      key          => $::sshdsakey,
    }
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

}
