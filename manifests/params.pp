class prosody::params {
  $admins                 = []
  $pidfile                = '/var/run/prosody/prosody.pid'
  $user                   = 'root'
  $group                  = 'root'
  $info_log               = '/var/log/prosody/prosody.log'
  $error_log              = '/var/log/prosody/prosody.err'
  $log_sinks              = ['syslog']
  $use_libevent           = true
  $interfaces             = ['0.0.0.0', '::']
  $allow_registration     = false
  $allow_root             = false
  $ssl_protocol           = 'tlsv1'
  $ssl_options            = ['no_ticket', 'no_compression', 'cipher_server_preference']
  $ssl_ciphers            = 'DH+AES:ECDH+AES:+ECDH+SHA:AES:!PSK:!SRP:!DSS:!ADH:!AECDH'
  $ssl_dhparam            = undef
  $ssl_curve              = 'secp521r1'
  $c2s_require_encryption = true
  $s2s_require_encryption = true
  $s2s_secure_auth        = true
  $s2s_insecure_domains   = []
  $s2s_secure_domains     = []
  $authentication         = 'internal_plain'
  $modules_base           = [ 'roster', 'saslauth', 'tls', 'dialback', 'disco', 'posix',
                              'private', 'vcard', 'version', 'uptime', 'time', 'ping',
                              'pep', 'admin_adhoc' ]
  $modules              = []
  $community_modules    = []
  $components           = {}
  $virtualhosts         = {}
  $virtualhost_defaults = {}
  $custom_options       = {}
}
