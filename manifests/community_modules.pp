class prosody::community_modules (
  $path = '/var/lib/prosody/modules',
  $modules = [],
) {

  ensure_packages(['mercurial'])
  vcsrepo { $path:
    ensure   => present,
    provider => hg,
    source   => 'https://code.google.com/p/prosody-modules/',
    require  => Package['mercurial'],
  }

  each($modules) |$module| {
    file { "/usr/lib/prosody/modules/mod_${module}.lua":
      ensure => link,
      target => "${path}/mod_${module}/mod_${module}.lua",
      notify => Class['prosody::service'],
    }
  }
}
