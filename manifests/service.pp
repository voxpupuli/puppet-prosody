# == Class: prosody::service
class prosody::service {
  if $prosody::daemonize {
    case $facts['os']['family'] {
      'OpenBSD': {
        service { 'prosody':
          ensure  => running,
          enable  => true,
          require => Class[prosody::config],
        }
      }
      default: {
        service { 'prosody' :
          ensure    => running,
          hasstatus => false,
          restart   => '/usr/bin/prosodyctl reload',
          require   => Class[prosody::config],
        }
      }
    }
  }
}
