class prosody::community_modules (
  $path = '/var/lib/prosody/modules',
  $source = 'https://code.google.com/p/prosody-modules/',
  $revision = undef,
) {
  ensure_packages(['mercurial'])

  vcsrepo { $path:
    ensure   => present,
    provider => hg,
    source   => $source,
    revision => $revision,
    require  => Package['mercurial'],
  }
}
