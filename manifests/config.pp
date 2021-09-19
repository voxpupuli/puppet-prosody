# == Class: prosody::config
class prosody::config (
  Stdlib::Absolutepath  $config_directory,
) {
  file { "${config_directory}/conf.avail":
    ensure => directory,
  }

  file { "${config_directory}/conf.d":
    ensure => directory,
  }

  file { "${config_directory}/prosody.cfg.lua":
    content => template('prosody/prosody.cfg.erb'),
    require => Class['prosody::package'],
    notify  => Class['prosody::service'],
  }
}
