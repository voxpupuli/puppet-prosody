Given /^I have an empty Linux machine$/ do
  @fleet = Blimpy.fleet do |fleet|
    fleet.add(:aws) do |ship|
      ship.name = "prosody-cucumber"
      # Ubuntu 12.04 LTS in us-west-2
      ship.image_id = 'ami-4038b470'
      ship.region = 'us-west-2'
      ship.livery = Blimpy::Livery::Puppet
    end
  end

  # Make sure we set up our object properly
  expect(@fleet).to_not be_nil
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

  @fleet.start
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

