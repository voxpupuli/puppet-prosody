# == Class: prosody
class prosody(
  String                         $package_name           = 'prosody',
  Variant[
    Enum[present, latest],
    String
  ]                              $package_ensure         = present,
  Array[String]                  $admins                 = [],
  Stdlib::Absolutepath           $pidfile                = '/var/run/prosody/prosody.pid',
  String                         $user                   = 'prosody',
  String                         $group                  = 'prosody',
  Enum[
    'debug',
    'info',
    'warn',
    'error' # lint:ignore:trailing_comma # (Bug in puppet-lint)
  ]                              $log_level              = 'info',
  Stdlib::Absolutepath           $info_log               = '/var/log/prosody/prosody.log',
  Stdlib::Absolutepath           $error_log              = '/var/log/prosody/prosody.err',
  Array[String]                  $log_sinks              = ['syslog'],
  Boolean                        $use_libevent           = true,
  Array[Stdlib::IP::Address]     $interfaces             = ['0.0.0.0', '::'],
  Boolean                        $daemonize              = true,
  Boolean                        $allow_registration     = false,
  Boolean                        $ssl_custom_config      = true,
  Optional[Stdlib::Absolutepath] $ssl_key                = undef,
  Optional[Stdlib::Absolutepath] $ssl_cert               = undef,
  Optional[String]               $ssl_protocol           = undef,
  Array[String]                  $ssl_options            = [
    'no_sslv2', 'no_sslv3', 'no_ticket', 'no_compression',
    'cipher_server_preference', 'single_dh_use', 'single_ecdh_use',
  ],
  String                         $ssl_ciphers            = 'DH+AES:ECDH+AES:+ECDH+SHA:AES:!PSK:!SRP:!DSS:!ADH:!AECDH',
  String                         $ssl_dhparam            = '', # lint:ignore:empty_string_assignment
  String                         $ssl_curve              = 'secp521r1',
  Boolean                        $c2s_require_encryption = true,
  Boolean                        $s2s_require_encryption = true,
  Boolean                        $s2s_secure_auth        = true,
  Array[Stdlib::Fqdn]            $s2s_insecure_domains   = [],
  Array[Stdlib::Fqdn]            $s2s_secure_domains     = [],
  Enum[
    'internal_plain',
    'internal_hashed',
    'cyrus',
    'anonymous' # lint:ignore:trailing_comma # (Bug in puppet-lint)
  ]                              $authentication         = 'internal_plain',
  Variant[
    Hash,
    Enum[
      'internal',
      'sql',
      'memory',
      'null',
      'none' # lint:ignore:trailing_comma # (Bug in puppet-lint)
    ]
  ]                              $storage                = 'internal',
  Optional[Hash]                 $sql                    = undef,
  Array[String]                  $modules_base           = [
    'roster', 'saslauth', 'tls', 'dialback', 'disco',
    'posix', 'private', 'vcard', 'version', 'uptime',
    'time', 'ping', 'pep', 'admin_adhoc',
  ],
  Array[String]                  $modules                = [],
  Array[String]                  $modules_disabled       = [],
  Array[String]                  $community_modules      = [],
  Hash                           $components             = {},
  Hash                           $virtualhosts           = {},
  Hash                           $virtualhost_defaults   = {},
  Hash                           $custom_options         = {},
) {
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
