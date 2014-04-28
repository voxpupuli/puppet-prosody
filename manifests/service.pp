class prosody::service {
  service {
    'prosody' :
      ensure    => running,
      hasstatus => false,
      restart   => '/usr/bin/prosodyctl reload',
      require   => Class[prosody::package],
  }
}
