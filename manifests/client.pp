# == Class: ssh::client
#
# Configures the openssh client.
#
# === Parameters
#
# [*manage_known_hosts*]
#   If global ssh_known_hosts should be managed (i.e. exported keys collected)
#   default: true
#
# === Examples
#
# class { 'ssh::client': }
#
# === Authors
#
# Frederik Wagner <wagner@wagit.de>
#
# === Copyright
#
# Copyright 2014 Frederik Wagner
#
class ssh::client (
  $manage_known_hosts = ssh::client::params::manage_known_hosts,
) inherits ssh::client::params {

  validate_bool($manage_known_hosts)

  class { 'ssh::client::install': } ->
  class { 'ssh::client::config': }

  if $manage_known_hosts {
    Class['ssh::client::config'] ->
    class { 'ssh::client::sshknownhosts': }
  }

}
