class prosody (
  $package_name           = 'prosody',
  $package_ensure         = 'present',
  $admins                 = [],
  $pidfile                = '/var/run/prosody/prosody.pid',
  $user                   = 'prosody',
  $group                  = 'prosody',
  $log_level              = 'info',
  $info_log               = '/var/log/prosody/prosody.log',
  $error_log              = '/var/log/prosody/prosody.err',
  $log_sinks              = ['syslog'],
  $use_libevent           = true,
  $interfaces             = ['0.0.0.0', '::'],
  $daemonize              = true,
  $allow_registration     = false,
  $ssl_key                = undef,
  $ssl_cert               = undef,
  $ssl_protocol           = undef,
  $ssl_options            = [
    'no_sslv2', 'no_sslv3', 'no_ticket', 'no_compression',
    'cipher_server_preference', 'single_dh_use', 'single_ecdh_use',
  ],
  $ssl_ciphers            = 'DH+AES:ECDH+AES:+ECDH+SHA:AES:!PSK:!SRP:!DSS:!ADH:!AECDH',
  $ssl_dhparam            = '', # lint:ignore:empty_string_assignment
  $ssl_curve              = 'secp521r1',
  $c2s_require_encryption = true,
  $s2s_require_encryption = true,
  $s2s_secure_auth        = true,
  $s2s_insecure_domains   = [],
  $s2s_secure_domains     = [],
  $authentication         = 'internal_plain',
  $storage                = 'internal',
  $sql                    = undef,
  $modules_base           = [
    'roster', 'saslauth', 'tls', 'dialback', 'disco',
    'posix', 'private', 'vcard', 'version', 'uptime',
    'time', 'ping', 'pep', 'admin_adhoc',
  ],
  $modules                = [],
  $modules_disabled       = [],
  $community_modules      = [],
  $components             = {},
  $virtualhosts           = {},
  $virtualhost_defaults   = {},
  $custom_options         = {},
) {
  validate_bool($use_libevent)
  validate_bool($daemonize)
  validate_bool($allow_registration)
  validate_bool($c2s_require_encryption)
  validate_bool($s2s_require_encryption)
  validate_bool($s2s_secure_auth)

  validate_string($pidfile)
  validate_string($user)
  validate_string($group)
  validate_string($info_log)
  validate_string($error_log)
  validate_string($ssl_protocol)
  validate_string($ssl_ciphers)
  if $ssl_dhparam != undef {
    validate_string($ssl_dhparam)
  }
  if $ssl_key != undef {
    validate_string($ssl_key)
  }
  if $ssl_cert != undef {
    validate_string($ssl_cert)
  }
  validate_string($ssl_curve)
  validate_string($authentication)
  validate_string($package_name)
  validate_string($package_ensure)

  validate_array($admins)
  validate_array($log_sinks)
  validate_array($interfaces)
  validate_array($ssl_options)
  validate_array($s2s_insecure_domains)
  validate_array($s2s_secure_domains)
  validate_array($modules_base)
  validate_array($modules)
  validate_array($modules_disabled)
  validate_array($community_modules)

  validate_hash($components)
  validate_hash($virtualhosts)
  validate_hash($virtualhost_defaults)
  validate_hash($custom_options)

  if ($community_modules != []) {
    class { '::prosody::community_modules':
      require => Class['::prosody::package'],
      before  => Class['::prosody::config'],
    }
  }

  anchor { 'prosody::begin': }
  -> class { '::prosody::package': }
  -> class { '::prosody::config': }
  -> class { '::prosody::service': }
  -> anchor { '::prosody::end': }

  # create virtualhost resources via hiera
  create_resources('prosody::virtualhost', $virtualhosts, $virtualhost_defaults)
}
