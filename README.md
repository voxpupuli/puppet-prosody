![Prosody](http://prosody.im/prosody.png)

This Puppet module is for the [Prosody](http://prosody.im/) Jabber/XMPP server.

Currently it is still in development.


## Using

**Note:** This module only supports Ubuntu currently

```puppet
node default {
  include prosody

  prosody::virtualhost {
    'mydomain.com' :
      ensure => present;
  }
}
```

### Support

Please file bugs and enhancement requests in the [GitHub issue tracker](https://github.com/rtyler/puppet-prosody/issues)
