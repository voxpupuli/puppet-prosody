class prosody (
  $admins = [],
  $pidfile = '/var/run/prosody/prosody.pid',
  $interfaces = ['0.0.0.0', '::'],
  $allow_registration = false,
  $ssl_protocol = 'tlsv1',
  $ssl_options = ['no_ticket', 'no_compression', 'cipher_server_preference'],
  $ssl_ciphers = 'DH+AES:ECDH+AES:+ECDH+SHA:AES:!PSK:!SRP:!DSS:!ADH:!AECDH',
  $ssl_dhparam = undef,
  $ssl_curve = 'secp521r1',
  $c2s_require_encryption = true,
  $s2s_require_encryption = true,
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
  $virtualhosts = {},
  $virtualhost_defaults = {},
) {
  validate_array($community_modules)

  if ($community_modules != []) {
    class { 'prosody::community_modules':
      require => Class['prosody::package'],
      before  => Class['prosody::config'],
    }
  }

  anchor { 'prosody::begin': }  ->
  class { 'prosody::package': } ->
  class { 'prosody::config': }  ->
  class { 'prosody::service': } ->
  anchor { 'prosody::end': }

  # create virtualhost resources via hiera
  create_resources('prosody::virtualhost', $virtualhosts, $virtualhost_defaults)
}
