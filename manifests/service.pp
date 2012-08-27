class prosody::service {
  service {
    'prosody' :
      ensure  => running,
      require => Class[prosody::package];
  }
}
