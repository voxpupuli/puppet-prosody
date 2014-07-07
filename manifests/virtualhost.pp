define prosody::virtualhost(
  $ensure   = 'present',
  $ssl_key  = 'UNSET',
  $ssl_cert = 'UNSET'
  ) {

  # Check if SSL set correctly
  if (($ssl_key != 'UNSET') and ($ssl_cert == 'UNSET')) {
    fail('The prosody::virtualhost type needs both ssl_key *and* ssl_cert set')
  }
  if (($ssl_key == 'UNSET') and ($ssl_cert != 'UNSET')) {
    fail('The prosody::virtualhost type needs both ssl_key *and* ssl_cert set')
  }

  if (($ssl_key != 'UNSET') and ($ssl_cert != 'UNSET')) {
    # Copy the provided sources to prosody certs folder
    $prosody_ssl_key  = "/etc/prosody/certs/${name}.key"
    $prosody_ssl_cert = "/etc/prosody/certs/${name}.cert"

    file {
      $prosody_ssl_key:
        source => $ssl_key,
        owner  => $prosody::user,
        group  => $prosody::group;
      $prosody_ssl_cert:
        source => $ssl_cert,
        owner  => $prosody::user,
        group  => $prosody::group;
    }

    $config_requires = [File[$prosody_ssl_key], File[$prosody_ssl_cert], Class[prosody::package]]
  }
  else {
    $config_requires = Class[prosody::package]
  }

  file { "/etc/prosody/conf.avail/${name}.cfg.lua":
      ensure  => $ensure,
      require => $config_requires,
      content => template('prosody/virtualhost.cfg.erb'),
      notify  => Service[prosody];
  }

  $cfg_ensure = $ensure ? {
    'present' => link,
    'absent'  => absent,
  }

  file { "/etc/prosody/conf.d/${name}.cfg.lua":
    ensure  => $cfg_ensure,
    target  => "/etc/prosody/conf.avail/${name}.cfg.lua",
    notify  => Service[prosody],
    require => File["/etc/prosody/conf.avail/${name}.cfg.lua"];
  }
}
