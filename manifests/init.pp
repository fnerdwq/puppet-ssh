# == Class: ssh
#
# This class configures the openssh server and client.
# Here only the subclasses are included. See there for
# further details.
#
# This works on Debian and RedHat like systems.
# Puppet Version >= 3.4.0
#
# === Examples
#
# include ssh
#
# === Authors
#
# Frederik Wagner <wagner@wagit.de>
#
# === Copyright
#
# Copyright 2014 Frederik Wagner
#
class ssh {

  include ssh::server
  include ssh::client

}
