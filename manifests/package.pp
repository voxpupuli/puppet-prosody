class prosody::package {
  package { $::prosody::package_name:
    ensure  => $::prosody::package_ensure,
  }
}
