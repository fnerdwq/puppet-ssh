# == Class: ssh::client
#
# Configures the openssh client.
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
class ssh::client inherits ssh::client::params {

  class { 'ssh::client::install': }
  -> class { 'ssh::client::config': }
  -> class { 'ssh::client::sshknownhosts': }

}
