# @summary Manage VCS
#
class prosody::community_modules (
  Enum[present, latest] $ensure,
  Stdlib::Absolutepath $path,
  String $source,
  Enum['hg', 'git', 'os'] $type,
  Optional[String] $revision = undef,
) {
  if $type == 'hg' {
    $_packages = ['mercurial']
  } elsif $type == 'git' {
    $_packages = ['git']
  } elsif $type == 'os' {
    $_packages = ['net-im/prosody-modules']
  }

  ensure_packages($_packages)
  case $type {
    'os': {}
    default:   {
      vcsrepo { $path:
        ensure   => $ensure,
        provider => $type,
        source   => $source,
        revision => $revision,
        require  => Package[$_packages],
      }
    }
  }
}
