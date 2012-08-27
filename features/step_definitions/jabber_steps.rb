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
  pending # express the regexp above with the code you wish you had
end

Then /^it should be listening for connections$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^then firewall has been configured to allow Jabber through$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the Jabber port should be open to the outside world$/ do
  pending # express the regexp above with the code you wish you had
end

