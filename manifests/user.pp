define prosody::user (
  $pass,
  $host = 'localhost',
) {
  $dir = regsubst($host, '\.', '%2e', 'G')

  ensure_resource('file', "/var/lib/prosody/${dir}", {
    ensure => 'directory',
    owner  => 'prosody',
    group  => 'prosody',
  })

  ensure_resource('file', "/var/lib/prosody/${dir}/accounts", {
    ensure  => 'directory',
    owner   => 'prosody',
    group   => 'prosody',
    require => File["/var/lib/prosody/${dir}"],
  })

  $_content = "
return {
  [\"password\"] = \"${pass}\";
};
"
  file {"/var/lib/prosody/${dir}/accounts/${name}.dat":
    owner   => 'prosody',
    group   => 'prosody',
    mode    => '0640',
    content => $_content,
    require => File["/var/lib/prosody/${dir}/accounts"],
  }
}
