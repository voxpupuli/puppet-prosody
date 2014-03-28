class prosody::package {
  if ($operatingsystem != 'Ubuntu') {
    fail("Currently the prosody module only supports Ubuntu\nSee <https://github.com/Mayflower/puppet-prosody> for more")
  }

  package { 'prosody' :
    ensure  => present,
  }
}
