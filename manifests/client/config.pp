# Set up ssh client configuration files
class ssh::client::config {

  file { '/etc/ssh/ssh_config':
    ensure  => present,
    mode    => '0644',
    owner   => root,
    group   => root,
    content => template('ssh/ssh_config.erb'),
  }

  # this file should be readable for everyone (Sshkey, does not create it right)
  file { '/etc/ssh/ssh_known_hosts' :
    ensure  => present,
    mode    => '0644',
    owner   => root,
    group   => root,
  }

  # delete not available sshkey
  resources { 'sshkey': purge => true }

  # collect all host rsa/dsa keys to put in ssh_known_hosts
  Sshkey <<||>> {
    require => File['/etc/ssh/ssh_known_hosts'],
  }

}
