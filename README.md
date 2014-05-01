![Prosody](http://prosody.im/prosody.png)

Puppet module for the [Prosody](http://prosody.im/) Jabber/XMPP server.

This module is a fork of rtyler/puppet-prosody because the upstream is dead. A
bunch of features were added and bugs were fixed.

If you want to use Prosody in a production environment, this is the Puppet
module to use.

## Using

**Note:** This module currently only supports Ubuntu.

```puppet
node default {
  include prosody

  prosody::virtualhost {
    'mydomain.com' :
      ensure => present;
  }
}
```

## Support

Please file bugs and enhancement requests in the [GitHub issue tracker](https://github.com/rtyler/puppet-prosody/issues)
