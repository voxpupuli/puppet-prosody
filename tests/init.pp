
node default {
  include prosody
  group {
    'puppet' :
      ensure => present;
  }

  prosody::virtualhost {
    'puppetlabs.com' :
      ensure => present;
  }
}
