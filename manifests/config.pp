# == Class: prosody::config
class prosody::config {
  include prosody

  file { "${prosody::config_directory}/conf.avail":
    ensure => directory,
  }

  file { "${prosody::config_directory}/conf.d":
    ensure => directory,
  }

  file { "${prosody::config_directory}/prosody.cfg.lua":
    content => template('prosody/prosody.cfg.erb'),
    require => Class['prosody::package'],
    notify  => Class['prosody::service'],
  }
}
