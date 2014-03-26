class prosody (
  $admins = [],
  $interfaces = ['0.0.0.0', '::'],
  $allow_registration = false,
  $ssl_protocol = 'tlsv1',
  $ssl_options = ['no_ticket', 'no_compression', 'cipher_server_preference'],
  $ssl_ciphers = 'DH+AES:ECDH+AES:+ECDH+SHA:AES:!PSK:!SRP:!DSS:!ADH:!AECDH',
  $ssl_dhparam = undef,
  $ssl_curve = 'secp521r1',
  $c2s_require_encryption = true,
  $s2s_secure_auth = true,
  $s2s_insecure_domains = [],
  $s2s_secure_domains = [],
  $authentication = 'internal_plain',
  $components = {},
  $modules_base = ['roster', 'saslauth', 'tls', 'dialback', 'disco', 'posix',
                   'private', 'vcard', 'version', 'uptime', 'time', 'ping',
                   'pep', 'admin_adhoc'],
  $modules = [],
  $community_modules = [],
  $custom_options = {},
) {
  anchor { 'prosody::begin': }  ->
  class { 'prosody::package': } ->
  class { 'prosody::config': }  ->
  class { 'prosody::service': } ->
  anchor { 'prosody::end': }

  if ($community_modules != [] and $community_modules != undef) {
    class { 'prosody::community_modules':
      modules => $community_modules,
      require => Class['prosody::package'],
      before  => Class['prosody::service'],
    }
  }
}
