# == Class: prosody::community_modules
class prosody::community_modules(
  Enum[present, latest] $ensure   = present,
  Stdlib::Absolutepath  $path     = '/var/lib/prosody/modules',
  Enum['hg', 'git']     $type     = 'hg',
  String                $source   = 'https://hg.prosody.im/prosody-modules/',
  Optional[String]      $revision = undef,
) {
  case $type {
    'hg':    { $_packages = ['mercurial'] }
    'git':   { $_packages = ['git'] }
    default: { $_packages = [] }
  }
  ensure_packages($_packages)
  -> vcsrepo { $path:
    ensure   => $ensure,
    provider => $type,
    source   => $source,
    revision => $revision,
  }
}
