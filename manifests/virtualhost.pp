define prosody::virtualhost (
  $custom_options = {},
  $ensure         = present,
  $ssl_key        = undef,
  $ssl_cert       = undef,
  $user           = undef,
  $group          = undef,
  $components     = {},
) {
  # Check if SSL set correctly
  if (($ssl_key != undef) and ($ssl_cert == undef)) {
    fail('The prosody::virtualhost type needs both ssl_key *and* ssl_cert set')
  }
  if (($ssl_key == undef) and ($ssl_cert != undef)) {
    fail('The prosody::virtualhost type needs both ssl_key *and* ssl_cert set')
  }

  if (($ssl_key != undef) and ($ssl_cert != undef)) {
    # Copy the provided sources to prosody certs folder
    $prosody_ssl_key  = "/etc/prosody/certs/${name}.key"
    $prosody_ssl_cert = "/etc/prosody/certs/${name}.cert"

    $file_user = pick_default($user, 'prosody')
    $file_group = pick_default($group, 'prosody')

    file {
      $prosody_ssl_key:
        source => $ssl_key,
        links  => follow,
        mode   => '0640',
        owner  => $file_user,
        group  => $file_group;
      $prosody_ssl_cert:
        source => $ssl_cert,
        links  => follow,
        mode   => '0644',
        owner  => $file_user,
        group  => $file_group;
    }

    $config_requires = [File[$prosody_ssl_key], File[$prosody_ssl_cert], Class['::prosody::package']]
  }
  else {
    $config_requires = Class['::prosody::package']
  }

  $conf_avail_fn = "/etc/prosody/conf.avail/${name}.cfg.lua"

  file { $conf_avail_fn:
      ensure  => $ensure,
      require => $config_requires,
      content => template('prosody/virtualhost.cfg.erb'),
      notify  => Class['::prosody::service'],
  }

  $cfg_ensure = $ensure ? {
    'present' => link,
    'absent'  => absent,
  }

  file { "/etc/prosody/conf.d/${name}.cfg.lua":
    ensure  => $cfg_ensure,
    target  => $conf_avail_fn,
    notify  => Class['::prosody::service'],
    require => File[$conf_avail_fn];
  }
}
