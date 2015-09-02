class prosody::service {
  if $prosody::daemonize {
    case $::osfamily {
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
