# == Class: prosody::package
class prosody::package {
  package { $prosody::package_name:
    ensure => $prosody::package_ensure,
  }

  if $prosody::manage_repository {
    $_keyring_path = '/usr/share/keyrings/prosody.gpg'

    apt::source { 'prosody':
      comment  => 'Prosody',
      location => "[signed-by=${_keyring_path}] https://packages.prosody.im/debian",
      release  => $facts['os']['distro']['codename'],
      repos    => 'main',
      before   => Package[$prosody::package_name],
    }

    file { $_keyring_path:
      source => $prosody::repo_key,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      before => Package[$prosody::package_name],
    }
  }
}
