# @summary Manage Prosody
#
# @param use_libevent
#   use libevent for keeping track of network connections
#   this parameter is deprecated, in favor of 
#   network_backend (use options to set value)
#   
# @param daemonize
#   if the server should be sent to background or not
#   deprecated since prosody version 0.12
#
class prosody (
  Array[String] $admins,
  Boolean $allow_registration,
  Enum['internal_plain', 'internal_hashed', 'cyrus', 'anonymous', 'ha1', 'ldap'] $authentication,
  Boolean $c2s_require_encryption,
  Array[String] $community_modules,
  Hash $components,
  Hash $custom_options,
  Optional[Boolean] $daemonize,
  Stdlib::Absolutepath $error_log,
  String $group,
  Stdlib::Absolutepath $info_log,
  Array[Stdlib::IP::Address] $interfaces,
  Prosody::Loglevel $log_level,
  Array[String] $log_sinks,
  Hash[Optional[Prosody::Loglevel], Data] $log_advanced,
  Array[String] $modules,
  Array[String] $modules_base,
  Array[String] $modules_disabled,
  String[1] $package_ensure,
  String $package_name,
  Boolean $manage_repository,
  String $repo_key,
  Stdlib::Absolutepath $pidfile,
  Array[Stdlib::Fqdn] $s2s_insecure_domains,
  Boolean $s2s_require_encryption,
  Boolean $s2s_secure_auth,
  Array[Stdlib::Fqdn] $s2s_secure_domains,
  String $ssl_ciphers,
  String $ssl_curve,
  Boolean $ssl_custom_config,
  String $ssl_dhparam,
  Array[String] $ssl_options,
  Variant[Hash, Enum['internal', 'sql', 'memory', 'null', 'none']] $storage,
  Optional[Boolean] $use_libevent,
  String $user,
  Hash $virtualhost_defaults,
  Hash $virtualhosts,
  Array[String[1]] $disco_items = [],
  Optional[Hash] $sql = undef,
  Optional[Stdlib::Absolutepath] $ssl_cert = undef,
  Optional[Stdlib::Absolutepath] $ssl_key = undef,
  Optional[String] $ssl_protocol = undef,
  Optional[Boolean] $manage_service = undef,
) {
  if ($community_modules != []) {
    class { 'prosody::community_modules':
      require => Class['prosody::package'],
      before  => File['/etc/prosody/prosody.cfg.lua'],
    }
  }

  contain 'prosody::package'
  contain 'prosody::service'

  Class['prosody::package']
  ~> Class['prosody::service']

  file { ['/etc/prosody/conf.avail', '/etc/prosody/conf.d']:
    ensure  => directory,
    require => Class['prosody::package'],
  }

  file { '/etc/prosody/prosody.cfg.lua':
    content => template('prosody/prosody.cfg.erb'),
    require => Class['prosody::package'],
    notify  => Class['prosody::service'],
  }

  # create virtualhost resources via hiera
  create_resources('prosody::virtualhost', $virtualhosts, $virtualhost_defaults)
}
