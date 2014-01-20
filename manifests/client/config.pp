# Set up ssh client configuration files (private)
class ssh::client::config {

  file { '/etc/ssh/ssh_config':
    ensure  => present,
    mode    => '0644',
    owner   => root,
    group   => root,
    content => template('ssh/ssh_config.erb'),
  }

}
