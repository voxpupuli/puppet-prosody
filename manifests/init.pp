class prosody (
  $admins = [],
  $allow_registration = false,
  $ssl_protocol = 'sslv23',
  $ssl_options = ['no_sslv2', 'no_ticket', 'no_compression', 'cipher_server_preference', 'no_sslv3'],
  $ssl_ciphers = 'DH+AES:ECDH+AES:+ECDH+SHA:AES:!PSK:!SRP:!DSS:!ADH:!AECDH',
  $ssl_curve = 'secp521r1',
  $c2s_require_encryption = true,
  $s2s_secure_auth = true,
  $s2s_insecure_domains = [],
  $s2s_secure_domains = [],
  $authentication = 'internal_plain',
  $components = {},
) {
  anchor { 'prosody::begin': }  ->
  class { 'prosody::package': } ->
  class { 'prosody::config': }  ->
  class { 'prosody::service': } ->
  anchor { 'prosody::end': }
}
