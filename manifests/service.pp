class prosody::service {
  case $::osfamily {
    'OpenBSD': {
      service { 'prosody':
        ensure  => $daemonize ? running : stopped,
        enable  => true,
        require => Class[prosody::config],
      }
    }
    default: {
      service { 'prosody' :
        ensure    => $daemonize ? running : stopped,
        hasstatus => false,
        restart   => '/usr/bin/prosodyctl reload',
        require   => Class[prosody::config],
      }
    }
  }
}
