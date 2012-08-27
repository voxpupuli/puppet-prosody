Given /^I have an empty Linux machine$/ do
  expect(vm).to_not be_nil
end

Given /^the machine should become a Jabber server$/ do
  resources << "class { 'prosody' : ; }"
end

When /^I provision the host$/ do
  resources << "group { 'puppet' : ensure => present; }"

  File.open(File.join(manifest_path, 'site.pp'), 'w') do |f|
    f.write("node default {\n")
    resources.each do |r|
      f.write("#{r}\n")
    end
    f.write("}\n")
  end

  start_vms
end

Then /^the Jabber server should be running$/ do
  # Using the `pgrep -f` option because prosody looks like:
  #   "lua /usr/bin/prosody"
  # in the process listing
  running = vm.ssh_into('pgrep -f prosody')
  expect(running).to be(true)
end

Then /^it should be listening for connections$/ do
  listening = vm.ssh_into('nc -z localhost 5269')
  expect(listening).to be(true)
  listening = vm.ssh_into('nc -z localhost 5222')
  expect(listening).to be(true)
end

Given /^then firewall has been configured to allow Jabber through$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the Jabber port should be open to the outside world$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^I have configured a virtualhost for "(.*?)"$/ do |vhostname|
  resources << """
  prosody::virtualhost {
    \"#{vhostname}\" :
      ensure => present;
  }
"""
end

Then /^the "(.*?)" configuration should be enabled$/ do |vhostname|
  exists = box.ssh_into("ls /etc/prosody/conf.d | grep #{vhostname}")
  expect(exists).to be(true)
end

