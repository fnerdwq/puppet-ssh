# == Class: ssh::server
#
# This class configures the openssh server.
#
# === Parameters
#
# Document parameters here.
#
# [*port*]
#   The port were ssh should listen, default: 22.
#
# [*passwordAuthentication*]
#   If PasswordAuthentication is allowed, default: yes.
#
# [*export_ssh_host_keys*]
#   If ssh_host_keys should be exported, to be collected by ssh::client
#   default: true
#
# === Examples
#
# class { 'ssh::server':
#    port => 2222,
# }
#
# === Authors
#
# Frederik Wagner <wagner@wagit.de>
#
# === Copyright
#
# Copyright 2014 Frederik Wagner
#
class ssh::server (
  $port                   = $ssh::server::params::port,
  $passwordAuthentication = $ssh::server::params::passwordAuthentication,
  $export_ssh_host_keys   = $ssh::server::params::export_ssh_host_keys,
) inherits ssh::server::params {

  if ! is_integer($port) { fail('Port should be an integer') }
  validate_re($passwordAuthentication, '^(yes|no)$')
  validate_bool($export_ssh_host_keys)

  class { 'ssh::server::install': } ->
  class { 'ssh::server::config': } ~>
  class { 'ssh::server::service': }

  if $export_ssh_host_keys {
    Class['ssh::server::service'] ->
    class { 'ssh::server::sshkeys': }
  }

}
