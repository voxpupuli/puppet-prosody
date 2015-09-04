class prosody (
  $admins                 = $::prosody::params::admins,
  $pidfile                = $::prosody::params::pidfile,
  $user                   = $::prosody::params::user,
  $group                  = $::prosody::params::group,
  $info_log               = $::prosody::params::info_log,
  $error_log              = $::prosody::params::error_log,
  $log_sinks              = $::prosody::params::log_sinks,
  $use_libevent           = $::prosody::params::use_libevent,
  $interfaces             = $::prosody::params::interfaces,
  $daemonize              = $::prosody::params::daemonize,
  $allow_registration     = $::prosody::params::allow_registration,
  $ssl_protocol           = $::prosody::params::ssl_protocol,
  $ssl_options            = $::prosody::params::ssl_options,
  $ssl_ciphers            = $::prosody::params::ssl_ciphers,
  $ssl_dhparam            = $::prosody::params::ssl_dhparam,
  $ssl_curve              = $::prosody::params::ssl_curve,
  $c2s_require_encryption = $::prosody::params::c2s_require_encryption,
  $s2s_require_encryption = $::prosody::params::s2s_require_encryption,
  $s2s_secure_auth        = $::prosody::params::s2s_secure_auth,
  $s2s_insecure_domains   = $::prosody::params::s2s_insecure_domains,
  $s2s_secure_domains     = $::prosody::params::s2s_secure_domains,
  $authentication         = $::prosody::params::authentication,
  $modules_base           = $::prosody::params::modules_base,
  $modules                = $::prosody::params::modules,
  $community_modules      = $::prosody::params::community_modules,
  $components             = $::prosody::params::components,
  $virtualhosts           = $::prosody::params::virtualhosts,
  $virtualhost_defaults   = $::prosody::params::virtualhost_defaults,
  $custom_options         = $::prosody::params::custom_options,
) inherits prosody::params {
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
  validate_string($ssl_curve)
  validate_string($authentication)

  validate_array($admins)
  validate_array($log_sinks)
  validate_array($interfaces)
  validate_array($ssl_options)
  validate_array($s2s_insecure_domains)
  validate_array($s2s_secure_domains)
  validate_array($modules_base)
  validate_array($modules)
  validate_array($community_modules)

  validate_hash($components)
  validate_hash($virtualhosts)
  validate_hash($virtualhost_defaults)
  validate_hash($custom_options)

  if ($community_modules != []) {
    class { 'prosody::community_modules':
      require => Class['prosody::package'],
      before  => Class['prosody::config'],
    }
  }

  anchor { 'prosody::begin': }  ->
  class { 'prosody::package': } ->
  class { 'prosody::config':
    daemonize => $daemonize,}  ->
  class { 'prosody::service':
    daemonize => $daemonize,
  } ->
  anchor { 'prosody::end': }

  # create virtualhost resources via hiera
  create_resources('prosody::virtualhost', $virtualhosts, $virtualhost_defaults)
}
