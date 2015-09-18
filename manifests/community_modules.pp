class prosody::community_modules (
  $ensure = 'present',
  $path = undef,
  $type = 'hg',
  $source = 'https://code.google.com/p/prosody-modules/',
  $revision = undef,
) {
  ensure_packages(['mercurial'])

  vcsrepo { $path:
    ensure   => $ensure,
    provider => $type,
    source   => $source,
    revision => $revision,
    require  => Package['mercurial'],
  }
}
