node default {
  include prosody

  prosody::virtualhost {
    'puppetlabs.com' :
      ensure => present;
  }
}
