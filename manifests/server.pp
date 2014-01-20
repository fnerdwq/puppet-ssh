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
# === Examples
#
# class { 'ssh-server':
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
  $port = 22,
  $passwordAuthentication = 'yes',
) inherits ssh::server::params {

  if ! is_integer($port) { fail('Port should be an integer') }
  validate_re($passwordAuthentication, '^(yes|no)$')

  class { 'ssh::server::install': }
  -> class { 'ssh::server::config': }
  ~> class { 'ssh::server::service': }
  -> class { 'ssh::server::sshkeys': }

}
