class prosody::service {
  service {
    'prosody' :
      ensure => running;
  }
}
