

define prosody::virtualhost($ensure='present', $ssl_key='UNSET', $ssl_cert='UNSET') {
  include prosody

  if (($ssl_key != 'UNSET') and ($ssl_cert == 'UNSET')) {
    fail("The prosody::virtualhost type needs both ssl_key *and* ssl_cert set")
  }
  if (($ssl_key == 'UNSET') and ($ssl_cert != 'UNSET')) {
    fail("The prosody::virtualhost type needs both ssl_key *and* ssl_cert set")
  }


  if (($ssl_key != 'UNSET') and ($ssl_cert != 'UNSET')) {
    $config_requires = [File[$ssl_key], File[$ssl_cert]]
  }
  else {
    $config_requires = ""
  }

  file {
    "${name}.cfg.lua" :
      ensure  => present,
      require => $config_requires,
      content => template('prosody/virtualhost.cfg.erb');
  }
}
