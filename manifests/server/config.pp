# configure ssh server (private)
class ssh::server::config {

  file { '/etc/ssh/sshd_config':
    ensure  => present,
    mode    => '0644',
    owner   => root,
    group   => root,
    content => template('ssh/sshd_config.erb'),
  }

}
