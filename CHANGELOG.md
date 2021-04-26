# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v1.0.0](https://github.com/voxpupuli/puppet-prosody/tree/v1.0.0) (2021-04-26)

[Full Changelog](https://github.com/voxpupuli/puppet-prosody/compare/0.4.0...v1.0.0)

**Breaking changes:**

- cleanup metadata.json / allow newer dependencies, Drop Puppet 5 support [\#70](https://github.com/voxpupuli/puppet-prosody/pull/70) ([bastelfreak](https://github.com/bastelfreak))

**Implemented enhancements:**

- Manage prosody upstream package repository [\#69](https://github.com/voxpupuli/puppet-prosody/pull/69) ([Bluewind](https://github.com/Bluewind))
- Allows to purge unused users [\#63](https://github.com/voxpupuli/puppet-prosody/pull/63) ([Bluewind](https://github.com/Bluewind))
- Manage disco\_items in a virtualhost [\#62](https://github.com/voxpupuli/puppet-prosody/pull/62) ([gfa](https://github.com/gfa))

**Fixed bugs:**

- Fix user creation if domain contains a dash [\#61](https://github.com/voxpupuli/puppet-prosody/pull/61) ([Bluewind](https://github.com/Bluewind))

**Closed issues:**

- Make a new release [\#54](https://github.com/voxpupuli/puppet-prosody/issues/54)

**Merged pull requests:**

- modulesync 3.0.0 & puppet-lint updates [\#65](https://github.com/voxpupuli/puppet-prosody/pull/65) ([bastelfreak](https://github.com/bastelfreak))
- Use rspec-puppet-facts for remaining tests / Add Ubuntu 16,18,20 support [\#64](https://github.com/voxpupuli/puppet-prosody/pull/64) ([Bluewind](https://github.com/Bluewind))
- When running on Debian, use its service management facilities [\#59](https://github.com/voxpupuli/puppet-prosody/pull/59) ([mmoll](https://github.com/mmoll))
- add a components example [\#57](https://github.com/voxpupuli/puppet-prosody/pull/57) ([baldurmen](https://github.com/baldurmen))
- Initial modulesync [\#56](https://github.com/voxpupuli/puppet-prosody/pull/56) ([mmoll](https://github.com/mmoll))
- allow newer puppetlabs-vcsrepo [\#53](https://github.com/voxpupuli/puppet-prosody/pull/53) ([mmoll](https://github.com/mmoll))
- Add a type for ha1 authentication method [\#52](https://github.com/voxpupuli/puppet-prosody/pull/52) ([gfa](https://github.com/gfa))
- Add support for advanced logging configuration [\#51](https://github.com/voxpupuli/puppet-prosody/pull/51) ([gfa](https://github.com/gfa))
- Optionally configure prosody to use an already deployed ssl cert and key [\#50](https://github.com/voxpupuli/puppet-prosody/pull/50) ([gfa](https://github.com/gfa))
- Support for deeply nested custom options [\#49](https://github.com/voxpupuli/puppet-prosody/pull/49) ([towo](https://github.com/towo))
- Use hiera 5 conventions [\#48](https://github.com/voxpupuli/puppet-prosody/pull/48) ([cocker-cc](https://github.com/cocker-cc))
- Use Puppet-4-Datatypes [\#47](https://github.com/voxpupuli/puppet-prosody/pull/47) ([cocker-cc](https://github.com/cocker-cc))
- Fix Tests [\#46](https://github.com/voxpupuli/puppet-prosody/pull/46) ([cocker-cc](https://github.com/cocker-cc))

## [0.4.0](https://github.com/voxpupuli/puppet-prosody/tree/0.4.0) (2019-04-08)

[Full Changelog](https://github.com/voxpupuli/puppet-prosody/compare/0.3.2...0.4.0)

**Merged pull requests:**

- enhance custom options to specify arrays and hashes [\#45](https://github.com/voxpupuli/puppet-prosody/pull/45) ([trefzer](https://github.com/trefzer))
- some updates  [\#44](https://github.com/voxpupuli/puppet-prosody/pull/44) ([trefzer](https://github.com/trefzer))
- Allow to pass a hash to custom\_options [\#43](https://github.com/voxpupuli/puppet-prosody/pull/43) ([lGuillaume124](https://github.com/lGuillaume124))

## [0.3.2](https://github.com/voxpupuli/puppet-prosody/tree/0.3.2) (2018-06-14)

[Full Changelog](https://github.com/voxpupuli/puppet-prosody/compare/0.3.1...0.3.2)

**Closed issues:**

- Update vcsrepo dependency to 2.2.0 [\#39](https://github.com/voxpupuli/puppet-prosody/issues/39)
- More Documentation [\#14](https://github.com/voxpupuli/puppet-prosody/issues/14)

**Merged pull requests:**

- Parse custom\_options of profile::virtualhost [\#42](https://github.com/voxpupuli/puppet-prosody/pull/42) ([amateo](https://github.com/amateo))
- Add support to register users [\#41](https://github.com/voxpupuli/puppet-prosody/pull/41) ([amateo](https://github.com/amateo))

## [0.3.1](https://github.com/voxpupuli/puppet-prosody/tree/0.3.1) (2017-11-20)

[Full Changelog](https://github.com/voxpupuli/puppet-prosody/compare/0.3.0...0.3.1)

**Closed issues:**

- PRs already merged if wanted [\#36](https://github.com/voxpupuli/puppet-prosody/issues/36)

**Merged pull requests:**

- Update vcsrepo requirement \(smaller 3\) [\#40](https://github.com/voxpupuli/puppet-prosody/pull/40) ([kallies](https://github.com/kallies))

## [0.3.0](https://github.com/voxpupuli/puppet-prosody/tree/0.3.0) (2017-09-11)

[Full Changelog](https://github.com/voxpupuli/puppet-prosody/compare/0.2.1...0.3.0)

**Implemented enhancements:**

- SSL Fixes [\#9](https://github.com/voxpupuli/puppet-prosody/pull/9) ([andschwa](https://github.com/andschwa))

**Closed issues:**

- Virtualhost specific ssl cert and UNSET keyword [\#28](https://github.com/voxpupuli/puppet-prosody/issues/28)
- Service sometimes tries to start again instead of reloading [\#27](https://github.com/voxpupuli/puppet-prosody/issues/27)

**Merged pull requests:**

- fix module repo source [\#38](https://github.com/voxpupuli/puppet-prosody/pull/38) ([toerb](https://github.com/toerb))
- add custom\_options to vhosts [\#35](https://github.com/voxpupuli/puppet-prosody/pull/35) ([tobru](https://github.com/tobru))
- add storage configuration [\#34](https://github.com/voxpupuli/puppet-prosody/pull/34) ([tobru](https://github.com/tobru))
- add modules\_disabled parameter [\#32](https://github.com/voxpupuli/puppet-prosody/pull/32) ([tobru](https://github.com/tobru))
- add ssl\_key and ssl\_cert to global ssl options [\#31](https://github.com/voxpupuli/puppet-prosody/pull/31) ([tobru](https://github.com/tobru))
- update community modules mercurial repo URL [\#30](https://github.com/voxpupuli/puppet-prosody/pull/30) ([tobru](https://github.com/tobru))
- fix unsafe default & improve doco [\#25](https://github.com/voxpupuli/puppet-prosody/pull/25) ([sammcj](https://github.com/sammcj))

## [0.2.1](https://github.com/voxpupuli/puppet-prosody/tree/0.2.1) (2014-10-27)

[Full Changelog](https://github.com/voxpupuli/puppet-prosody/compare/0.2.0...0.2.1)

**Closed issues:**

- Release new version at puppet-forge [\#19](https://github.com/voxpupuli/puppet-prosody/issues/19)

## [0.2.0](https://github.com/voxpupuli/puppet-prosody/tree/0.2.0) (2014-09-15)

[Full Changelog](https://github.com/voxpupuli/puppet-prosody/compare/0.1.3...0.2.0)

**Closed issues:**

- Prosody Repository [\#8](https://github.com/voxpupuli/puppet-prosody/issues/8)

**Merged pull requests:**

- Fix some style nits [\#18](https://github.com/voxpupuli/puppet-prosody/pull/18) ([jasperla](https://github.com/jasperla))
- Allow for defining logging sinks, such as syslog \(default\). [\#17](https://github.com/voxpupuli/puppet-prosody/pull/17) ([jasperla](https://github.com/jasperla))
- Allow for disabling luaevent as it may not work everywhere. [\#16](https://github.com/voxpupuli/puppet-prosody/pull/16) ([jasperla](https://github.com/jasperla))
- Prosody has an rc.d script on OpenBSD, so it can be enabled like any other service. [\#15](https://github.com/voxpupuli/puppet-prosody/pull/15) ([jasperla](https://github.com/jasperla))
- Allow changing the location of the log files [\#13](https://github.com/voxpupuli/puppet-prosody/pull/13) ([jasperla](https://github.com/jasperla))
- Allow changing the location of the pidfile. [\#12](https://github.com/voxpupuli/puppet-prosody/pull/12) ([jasperla](https://github.com/jasperla))
- Allow setting the user to run prosody as. [\#11](https://github.com/voxpupuli/puppet-prosody/pull/11) ([jasperla](https://github.com/jasperla))
- OpenBSD doesn't have conf.d by default, so ensure the directory exists. [\#10](https://github.com/voxpupuli/puppet-prosody/pull/10) ([jasperla](https://github.com/jasperla))

## [0.1.3](https://github.com/voxpupuli/puppet-prosody/tree/0.1.3) (2014-05-02)

[Full Changelog](https://github.com/voxpupuli/puppet-prosody/compare/0.1.2...0.1.3)

## [0.1.2](https://github.com/voxpupuli/puppet-prosody/tree/0.1.2) (2014-05-01)

[Full Changelog](https://github.com/voxpupuli/puppet-prosody/compare/0.1.1...0.1.2)

## [0.1.1](https://github.com/voxpupuli/puppet-prosody/tree/0.1.1) (2014-05-01)

[Full Changelog](https://github.com/voxpupuli/puppet-prosody/compare/0.1.0...0.1.1)

## [0.1.0](https://github.com/voxpupuli/puppet-prosody/tree/0.1.0) (2014-05-01)

[Full Changelog](https://github.com/voxpupuli/puppet-prosody/compare/d0cb2667ba2ab40028cc9e67716f9efb1cf6b2b2...0.1.0)

**Merged pull requests:**

- Clean branch that deletes those pesky lines [\#7](https://github.com/voxpupuli/puppet-prosody/pull/7) ([andschwa](https://github.com/andschwa))
- Removing openssl package [\#5](https://github.com/voxpupuli/puppet-prosody/pull/5) ([andschwa](https://github.com/andschwa))
- Using ensure\_packages instead of ensure\_resource [\#4](https://github.com/voxpupuli/puppet-prosody/pull/4) ([andschwa](https://github.com/andschwa))
- Updating repository URL [\#3](https://github.com/voxpupuli/puppet-prosody/pull/3) ([andschwa](https://github.com/andschwa))
- Removing libevent package \(bugfix\) [\#2](https://github.com/voxpupuli/puppet-prosody/pull/2) ([andschwa](https://github.com/andschwa))
- Add ability to create virtualhosts through hiera [\#1](https://github.com/voxpupuli/puppet-prosody/pull/1) ([andschwa](https://github.com/andschwa))



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
