# @summary Manage VCS
#
class prosody::community_modules (
  Enum[present, latest] $ensure,
  Stdlib::Absolutepath $path,
  String $source,
  Enum['hg', 'git', 'os'] $type,
  Optional[String] $revision = undef,
) {
  include prosody

  if $type == 'hg' {
    $_packages = ['mercurial']
  } elsif $type == 'git' {
    $_packages = ['git']
  } elsif $type == 'os' {
    package { $prosody::community_package_name:
      ensure => present,
    }
  }

  if $type != 'os' {
    ensure_packages($_packages)
    -> vcsrepo { $path:
      ensure   => $ensure,
      provider => $type,
      source   => $source,
      revision => $revision,
    }
  }
}
