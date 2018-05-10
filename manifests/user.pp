define prosody::user (
  $pass,
  $host = 'localhost',
) {
  $dir = regsubst($host, '\.', '%2e', 'G')

  exec {"create vhost dir ${name}":
    command => "/bin/mkdir -m 0750 /var/lib/prosody/${dir}",
    creates => "/var/lib/prosody/${dir}",
    user    => 'prosody',
    group   => 'prosody',
    require => Prosody::Virtualhost[$host],
  }

  exec {"create vhost user dir ${name}":
    command => "/bin/mkdir -m 0750 /var/lib/prosody/${dir}/accounts",
    creates => "/var/lib/prosody/${dir}/accounts",
    user    => 'prosody',
    group   => 'prosody',
    require => Exec["create vhost dir ${name}"],
  }

  # lint:ignore:strict_indent
  $_content = "
return {
  [\"password\"] = \"${pass}\";
};
"
  # lint:endignore
  file {"/var/lib/prosody/${dir}/accounts/${name}.dat":
    owner   => 'prosody',
    group   => 'prosody',
    mode    => '0640',
    content => $_content,
    require => Exec["create vhost user dir ${name}"],
  }
}
