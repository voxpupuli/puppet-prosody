

define prosody::virtualhost($ensure='present') {
  include prosody

  file {
    "${name}.cfg.lua" :
      ensure  => present,
      content => template('prosody/virtualhost.cfg.erb');
  }
}
