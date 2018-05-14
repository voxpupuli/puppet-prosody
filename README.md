![Prosody](http://prosody.im/prosody.png)

[![Build Status](https://travis-ci.org/mayflower/puppet-prosody.svg?branch=master)](https://travis-ci.org/mayflower/puppet-prosody)

Puppet module for the [Prosody](http://prosody.im/) Jabber/XMPP server.

This module is a fork of rtyler/puppet-prosody because the upstream is dead. A
bunch of features were added and bugs were fixed.

If you want to use Prosody in a production environment, this is the Puppet
module to use.

## Using

**Note:** This module has currently been tested on CentOS 7, Ubuntu and OpenBSD.

```puppet
node myserver {

  class { 'prosody':
    user              => 'prosody',
    group             => 'prosody',
    community_modules => ['mod_auth_ldap'],
    authentication    => 'ldap',
    custom_options    => {
                            'ldap_base'     => 'OU="accounts",DC="mydomain",DC="com"',
                            'ldap_server'   => 'ldapserver1:636 ldapserver2:636',
                            'ldap_rootdn'   => 'DN="prosody",OU="accounts",DC="mydomain",DC="com"',
                            'ldap_password' => hiera(prosody-ldap-password),
                            'ldap_scope'    => 'subtree',
                            'ldap_tls'      => 'true',
                          },
  }

  prosody::virtualhost {
    'mydomain.com' :
      ensure   => present,
      ssl_key  => '/etc/ssl/key/mydomain.com.key',
      ssl_cert => '/etc/ssl/crt/mydomain.com.crt',
  }

  prosody::user { 'foo':
    host => 'mydomain.com',
    pass => 'itsasecret',
  }
}
```

## Support

Please file bugs and enhancement requests in the [GitHub issue tracker](https://github.com/mayflower/puppet-prosody/issues)
