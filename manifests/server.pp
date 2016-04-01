# == Class: ssh::server
#
# This class configures the openssh server.
#
# === Parameters
#
# Document parameters here.
#
# [*port*]
#   The port were ssh should listen, default: 22
#
# [*selinux_policy*]
#   Whether or not to manage selinux ssh port policy,
#   default: false (Debian) / true (RedHat)
#
# [*pubkeyAuthentication*]
#   If PubkeyAuthentication is allowed, default: yes
#
# [*passwordAuthentication*]
#   If PasswordAuthentication is allowed, default: yes
#
# [*permitRootLogin*]
#   If Root login is allowed (PermitRootLogin), default: yes
#
# [*useDns*]
#   If DNS lookup is used (UseDNS), default: yes
#
# [*clientAliveInterval*]
#   Set ClientAliveInterval, default: 0
#
# [*strictModes*]
#   Set StrictModes, default: yes
#
# [*maxAuthTries*]
#   Set MaxAuthTries, default: 6
#
# [*ciphers*]
#   Sets the allowed Ciphers, default: undef
#
# [*kexAlgorithms*]
#   Sets the allowed KexAlogrithms, default: undef
#
# [*macs*]
#   Sets the allowed MACs, default: undef
#
# [*secure_moduli*]
#   Delete all DH moduli <= 2000 bit, default: false
#
# [*export_host_keys*]
#   If ssh_host_keys should be exported, to be collected by ssh::client
#   default: true
#
# [*host_aliases*]
#   List of aliases names for ssh_known_hosts.
#   default: []
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
  $selinux_policy         = $ssh::server::params::selinux_policy,
  $pubkeyAuthentication   = $ssh::server::params::pubkeyAuthentication,
  $passwordAuthentication = $ssh::server::params::passwordAuthentication,
  $permitRootLogin        = $ssh::server::params::permitRootLogin,
  $useDns                 = $ssh::server::params::useDns,
  $clientAliveInterval    = $ssh::server::params::clientAliveInterval,
  $strictModes            = $ssh::server::params::strictModes,
  $maxAuthTries           = $ssh::server::params::maxAuthTries,
  $kexAlgorithms          = $ssh::server::params::kexAlgorithms,
  $ciphers                = $ssh::server::params::ciphers,
  $macs                   = $ssh::server::params::macs,
  $secure_moduli          = $ssh::server::params::secure_moduli,
  $export_host_keys       = $ssh::server::params::export_host_keys,
  $host_aliases           = $ssh::server::params::host_aliases,
) inherits ssh::server::params {

  if ! is_integer($port) { fail('Port must be an integer') }
  validate_re($pubkeyAuthentication, '^(yes|no)$')
  validate_re($passwordAuthentication, '^(yes|no)$')
  validate_re($permitRootLogin, '^(yes|no|without-password|forced-commands-only)$')
  validate_re($useDns, '^(yes|no)$')
  if ! is_integer($clientAliveInterval) { fail('clientAliveInterval must be an integer') }
  validate_re($strictModes, '^(yes|no)$')
  if ! is_integer($maxAuthTries) { fail('maxAuthTries must be an integer') }
  # TODO: check kexAlgorithsm, ciphers, macs
  validate_bool($secure_moduli)
  validate_bool($export_host_keys)
  validate_array($host_aliases)

  class { 'ssh::server::install': } ->
  class { 'ssh::server::config': } ~>
  class { 'ssh::server::service': }

  if $export_host_keys {
    Class['ssh::server::service'] ->
    class { 'ssh::server::sshkeys': }
  }

}
