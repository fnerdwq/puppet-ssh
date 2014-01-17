# mange the ssh service
class ssh::server::service {

  service { 'ssh-server':
    ensure     => running,
    name       => $ssh::server::params::service,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }
}

