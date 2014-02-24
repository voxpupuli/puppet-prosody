class prosody::service {
  service {
    'prosody' :
      ensure    => running,
      hasstatus => false,
      require   => Class[prosody::package],
  }
}
