class prosody::config($daemonize = $prosody::params::daemonize)
  inherits prosody::params {
  file { '/etc/prosody/conf.avail':
    ensure => directory,
  }

  file { '/etc/prosody/conf.d':
    ensure => directory,
  }

  if $daemonize {
    $cfg_notify = Service['prosody']
  }
  else {
    $cfg_notify = undef
  }

  file { '/etc/prosody/prosody.cfg.lua':
    content => template('prosody/prosody.cfg.erb'),
    require => Class[prosody::package],
    notify  => $cfg_notify,
  }
}
