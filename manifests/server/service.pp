# mange the ssh service (private)
class ssh::server::service {

  service { 'ssh-server':
    ensure     => running,
    name       => $ssh::server::params::service,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }
}

