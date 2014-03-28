
class prosody::package {
  if ($operatingsystem != 'Ubuntu') {
    fail("Currently the prosody module only supports Ubuntu\nSee <https://github.com/rtyler/puppet-prosody> for more")
  }

  package { 'prosody' :
    ensure  => present,
    # Package[openssl] will be required to generate certificates and such
    require => Package[openssl];
  }

  if (!defined(Package[openssl])) {
    package {
      'openssl' :
        ensure => present;
    }
  }
}
