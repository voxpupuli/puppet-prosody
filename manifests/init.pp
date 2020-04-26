# == Class: prosody
class prosody(
  Array[String]                           $admins,
  Boolean                                 $allow_registration,
  Prosody::Authentication                 $authentication,
  Boolean                                 $c2s_require_encryption,
  Array[String]                           $community_modules,
  Hash                                    $components,
  Hash                                    $custom_options,
  Boolean                                 $daemonize,
  Stdlib::Absolutepath                    $error_log,
  String                                  $group,
  Stdlib::Absolutepath                    $info_log,
  Array[Stdlib::IP::Address]              $interfaces,
  Prosody::Loglevel                       $log_level,
  Array[String]                           $log_sinks,
  Hash[Optional[Prosody::Loglevel], Data] $log_advanced,
  Array[String]                           $modules,
  Array[String]                           $modules_base,
  Array[String]                           $modules_disabled,
  Prosody::Packageensure                  $package_ensure,
  String                                  $package_name,
  Stdlib::Absolutepath                    $pidfile,
  Array[Stdlib::Fqdn]                     $s2s_insecure_domains,
  Boolean                                 $s2s_require_encryption,
  Boolean                                 $s2s_secure_auth,
  Array[Stdlib::Fqdn]                     $s2s_secure_domains,
  String                                  $ssl_ciphers,
  String                                  $ssl_curve,
  Boolean                                 $ssl_custom_config,
  String                                  $ssl_dhparam,
  Array[String]                           $ssl_options,
  Prosody::Storage                        $storage,
  Boolean                                 $use_libevent,
  String                                  $user,
  Hash                                    $virtualhost_defaults,
  Hash                                    $virtualhosts,
  Optional[Array[String]]                 $disco_items  = undef,
  Optional[Hash]                          $sql          = undef,
  Optional[Stdlib::Absolutepath]          $ssl_cert     = undef,
  Optional[Stdlib::Absolutepath]          $ssl_key      = undef,
  Optional[String]                        $ssl_protocol = undef,
) {
  if ($community_modules != []) {
    class { 'prosody::community_modules':
      require => Class['::prosody::package'],
      before  => Class['::prosody::config'],
    }
  }

  contain 'prosody::package'
  contain 'prosody::config'
  contain 'prosody::service'

  Class['prosody::package']
  -> Class['prosody::config']
  ~> Class['prosody::service']

  # create virtualhost resources via hiera
  create_resources('prosody::virtualhost', $virtualhosts, $virtualhost_defaults)
}
