# == Define: prosody::user
define prosody::user(
  String        $pass,
  Prosody::Host $host = 'localhost',
) {
  $_dir1 = regsubst($host, '\.', '%2e', 'G')
  $dir = regsubst($_dir1, '-', '%2d', 'G')

  $_username1 = regsubst($name, '\.', '%2e', 'G')
  $_username = regsubst($_username1, '-', '%2d', 'G')

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
  file {"/var/lib/prosody/${dir}/accounts/${_username}.dat":
    owner   => 'prosody',
    group   => 'prosody',
    mode    => '0640',
    content => $_content,
    require => File["/var/lib/prosody/${dir}/accounts"],
  }
}
