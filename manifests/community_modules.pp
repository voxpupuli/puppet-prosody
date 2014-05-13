class prosody::community_modules (
  $path = '/var/lib/prosody/modules',
) {

  ensure_packages(['mercurial'])
  vcsrepo { $path:
    ensure   => present,
    provider => hg,
    source   => 'https://code.google.com/p/prosody-modules/',
    require  => Package['mercurial'],
  }
}
