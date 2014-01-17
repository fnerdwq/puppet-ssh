#puppet-ssh

####Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup - The basics of getting started with Ssh](#setup)
    * [What Ssh affects](#what-ssh-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with Ssh](#beginning-with-Ssh)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

This small ssh module manages the openssh server and client on RedHat and Debian like system. Up to now it just lets you configure some elementary settings. Ssh host keys are distributed via exported resources.

Written for Puppet >= 3.4.0.

##Module Description

See [Overview](#overview) for now.

##Setup

###What Ssh affects

* ssh :-) 

###Setup Requirements

The option `pluginsync` must be enabled.
Enable `storeconfigs` if you want to manage the host keys.
	
###Beginning with Ssh	

Simply include it.

##Usage

Just include the module by 

```puppet
include ssh
```

Configure it through hiera or declare it resource-like by calling the server/client class explicitly and set the parameters, e.g.:

```puppet
class { 'ssh::server':
  port                   => 2222,
  passwordAuthentication => 'no'
}
```

##Limitations:

Debian and RedHat like systems.
Tested on:

* Debian 7
* Centos 6.x

Puppet Version >= 3.4.0, due to specific hiera usage.

