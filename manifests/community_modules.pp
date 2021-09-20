# @summary Manage VCS
#
class prosody::community_modules (
  Enum[present, latest] $ensure,
  Stdlib::Absolutepath $path,
  String $source,
  Enum['hg', 'git'] $type,
  Optional[String] $revision = undef,
) {
  if $type == 'hg' {
    $_packages = ['mercurial']
  } elsif $type == 'git' {
    $_packages = ['git']
  }

  ensure_packages($_packages)
  -> vcsrepo { $path:
    ensure   => $ensure,
    provider => $type,
    source   => $source,
    revision => $revision,
  }
}
