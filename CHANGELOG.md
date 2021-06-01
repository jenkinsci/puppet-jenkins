# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v3.0.0](https://github.com/voxpupuli/puppet-jenkins/tree/v3.0.0) (2021-01-11)

[Full Changelog](https://github.com/voxpupuli/puppet-jenkins/compare/v2.0.0...v3.0.0)

**Breaking changes:**

- Remove params from jenkins::plugin and make it lint clean [\#985](https://github.com/voxpupuli/puppet-jenkins/pull/985) ([ekohl](https://github.com/ekohl))
- Drop code old CLI remoting support [\#984](https://github.com/voxpupuli/puppet-jenkins/pull/984) ([ekohl](https://github.com/ekohl))

**Implemented enhancements:**

- Add support for a custom JAVA\_HOME [\#217](https://github.com/voxpupuli/puppet-jenkins/issues/217)
- Should we include the puppet-jenkinstracking code? [\#110](https://github.com/voxpupuli/puppet-jenkins/issues/110)
- Implement ConduitCredentialsImpl in groovy\_helper [\#986](https://github.com/voxpupuli/puppet-jenkins/pull/986) ([ekohl](https://github.com/ekohl))
- Bugfix/custom localdir with user: Fixes \#462 [\#484](https://github.com/voxpupuli/puppet-jenkins/pull/484) ([vStone](https://github.com/vStone))

**Fixed bugs:**

- Update references to rtyler/jenkins in README [\#934](https://github.com/voxpupuli/puppet-jenkins/issues/934)
- Create jenkins user before installing the package with manage\_user [\#462](https://github.com/voxpupuli/puppet-jenkins/issues/462)
- Error in plugin version check algo? [\#192](https://github.com/voxpupuli/puppet-jenkins/issues/192)
- Fix a reference to jenkins::service [\#950](https://github.com/voxpupuli/puppet-jenkins/pull/950) ([ekohl](https://github.com/ekohl))
- Use variables for tries and try\_sleep everywhere instead of hardcoding [\#919](https://github.com/voxpupuli/puppet-jenkins/pull/919) ([jhooyberghs](https://github.com/jhooyberghs))

**Closed issues:**

- Puppet enterprise error line 425  Could not find class ::java [\#988](https://github.com/voxpupuli/puppet-jenkins/issues/988)
- Jenkins not installing on Centos 7 due to gpg key [\#979](https://github.com/voxpupuli/puppet-jenkins/issues/979)
- The Jenkins Debian package key needs to be updated [\#971](https://github.com/voxpupuli/puppet-jenkins/issues/971)
- Step /Jenkins::Cli/Exec\[jenkins-cli\] Fails on install [\#970](https://github.com/voxpupuli/puppet-jenkins/issues/970)
- Jenkins-CLI cli.pp [\#944](https://github.com/voxpupuli/puppet-jenkins/issues/944)
- Installed Credentials + Structs plugins are not pinned to a specific version [\#941](https://github.com/voxpupuli/puppet-jenkins/issues/941)
- remoting-cli setting removed in 2.165 [\#918](https://github.com/voxpupuli/puppet-jenkins/issues/918)
- repo parameter does not work [\#906](https://github.com/voxpupuli/puppet-jenkins/issues/906)
- Release new version? [\#891](https://github.com/voxpupuli/puppet-jenkins/issues/891)
- semi-regular triage/use case discussions? [\#857](https://github.com/voxpupuli/puppet-jenkins/issues/857)
- new Forge release checklist [\#855](https://github.com/voxpupuli/puppet-jenkins/issues/855)
- revert new CLI interface [\#854](https://github.com/voxpupuli/puppet-jenkins/issues/854)
- legacy CLI.jar remoting is broken [\#814](https://github.com/voxpupuli/puppet-jenkins/issues/814)
- use get-job to ensure that exists, before create it [\#787](https://github.com/voxpupuli/puppet-jenkins/issues/787)
- RSpec Testing when overriding default plugins [\#784](https://github.com/voxpupuli/puppet-jenkins/issues/784)

**Merged pull requests:**

- Lint clean and add more puppet-strings docs [\#995](https://github.com/voxpupuli/puppet-jenkins/pull/995) ([ekohl](https://github.com/ekohl))
- allow puppetlabs/java \< 7.0.0 [\#994](https://github.com/voxpupuli/puppet-jenkins/pull/994) ([saz](https://github.com/saz))
- Drop GoogleRobotPrivateKeyCredentials implementation [\#987](https://github.com/voxpupuli/puppet-jenkins/pull/987) ([ekohl](https://github.com/ekohl))
- Rewrite function tests to modern rspec-puppet [\#982](https://github.com/voxpupuli/puppet-jenkins/pull/982) ([ekohl](https://github.com/ekohl))
- Fix the plugin acceptance tests [\#981](https://github.com/voxpupuli/puppet-jenkins/pull/981) ([ekohl](https://github.com/ekohl))
- Fix BasicSSHUserPrivateKey acceptance test [\#978](https://github.com/voxpupuli/puppet-jenkins/pull/978) ([ekohl](https://github.com/ekohl))
- Update debian GPG key [\#972](https://github.com/voxpupuli/puppet-jenkins/pull/972) ([igalic](https://github.com/igalic))
- Feature/cli auth fix [\#965](https://github.com/voxpupuli/puppet-jenkins/pull/965) ([TomRitserveldt](https://github.com/TomRitserveldt))
- Use voxpupuli-acceptance [\#963](https://github.com/voxpupuli/puppet-jenkins/pull/963) ([ekohl](https://github.com/ekohl))
- Fix incorrect syntax in acceptance tests [\#958](https://github.com/voxpupuli/puppet-jenkins/pull/958) ([ekohl](https://github.com/ekohl))
- Drop okjson [\#956](https://github.com/voxpupuli/puppet-jenkins/pull/956) ([ekohl](https://github.com/ekohl))
- Respect manage\_service with Jenkins::Systemd\[Jenkins\] [\#955](https://github.com/voxpupuli/puppet-jenkins/pull/955) ([ekohl](https://github.com/ekohl))
- Avoid global variables in acceptance tests [\#954](https://github.com/voxpupuli/puppet-jenkins/pull/954) ([ekohl](https://github.com/ekohl))
- Remove unused file [\#953](https://github.com/voxpupuli/puppet-jenkins/pull/953) ([ekohl](https://github.com/ekohl))
- Drop Puppet 3.x code [\#952](https://github.com/voxpupuli/puppet-jenkins/pull/952) ([ekohl](https://github.com/ekohl))
- Use more expressive rspec syntax [\#951](https://github.com/voxpupuli/puppet-jenkins/pull/951) ([ekohl](https://github.com/ekohl))
- Reference jenkins\_plugins via $facts [\#949](https://github.com/voxpupuli/puppet-jenkins/pull/949) ([ekohl](https://github.com/ekohl))
- Remove redundant code [\#948](https://github.com/voxpupuli/puppet-jenkins/pull/948) ([ekohl](https://github.com/ekohl))
- Simplify the fact definition [\#947](https://github.com/voxpupuli/puppet-jenkins/pull/947) ([ekohl](https://github.com/ekohl))
- Switch to open source UUID generator [\#938](https://github.com/voxpupuli/puppet-jenkins/pull/938) ([aarreedd](https://github.com/aarreedd))
- Update references to rtyler/jenkins [\#935](https://github.com/voxpupuli/puppet-jenkins/pull/935) ([gguillotte](https://github.com/gguillotte))
- Clean up acceptance spec helper [\#931](https://github.com/voxpupuli/puppet-jenkins/pull/931) ([ekohl](https://github.com/ekohl))
- Rely more on stdlib and apt modules [\#917](https://github.com/voxpupuli/puppet-jenkins/pull/917) ([ekohl](https://github.com/ekohl))
- Refactor repository handling [\#882](https://github.com/voxpupuli/puppet-jenkins/pull/882) ([ekohl](https://github.com/ekohl))

## [v2.0.0](https://github.com/voxpupuli/puppet-jenkins/tree/v2.0.0) (2019-06-04)

[Full Changelog](https://github.com/voxpupuli/puppet-jenkins/compare/v1.7.0...v2.0.0)

**Breaking changes:**

- modulesync 2.7.0 and drop puppet 4 [\#908](https://github.com/voxpupuli/puppet-jenkins/pull/908) ([bastelfreak](https://github.com/bastelfreak))
- modulesync 2.4.0 + drop Ubuntu 14.04 [\#879](https://github.com/voxpupuli/puppet-jenkins/pull/879) ([bastelfreak](https://github.com/bastelfreak))

**Implemented enhancements:**

- Allow slave defaults management to be optional [\#619](https://github.com/voxpupuli/puppet-jenkins/issues/619)
- Update jenkins::slave::java\_args to be an array. [\#573](https://github.com/voxpupuli/puppet-jenkins/issues/573)
- resurrect PR \#467:  Support FileCredentialsImpl in jenkins\_credentials native type [\#529](https://github.com/voxpupuli/puppet-jenkins/issues/529)
- Default to running beaker tests on EC2 [\#401](https://github.com/voxpupuli/puppet-jenkins/issues/401)
- Including group parameter for jenkins slave [\#361](https://github.com/voxpupuli/puppet-jenkins/issues/361)
- Initscripts shouldn't call su/runuser as login shell [\#287](https://github.com/voxpupuli/puppet-jenkins/issues/287)
- Add puppet-doc-lint [\#178](https://github.com/voxpupuli/puppet-jenkins/issues/178)
- Darwin/osx support [\#112](https://github.com/voxpupuli/puppet-jenkins/issues/112)
- Add browserstack credentials support [\#897](https://github.com/voxpupuli/puppet-jenkins/pull/897) ([vStone](https://github.com/vStone))
- Add support for GoogleRobotPrivateKeyCredentials [\#861](https://github.com/voxpupuli/puppet-jenkins/pull/861) ([thaiphv](https://github.com/thaiphv))
- Run apt\_update when defining debian repos [\#821](https://github.com/voxpupuli/puppet-jenkins/pull/821) ([beezly](https://github.com/beezly))
- Feature/job replace parameter [\#759](https://github.com/voxpupuli/puppet-jenkins/pull/759) ([vStone](https://github.com/vStone))
- Fix https://github.com/jenkinsci/puppet-jenkins/issues/744 by setting mode explicitly [\#745](https://github.com/voxpupuli/puppet-jenkins/pull/745) ([elconas](https://github.com/elconas))
- Add support for conduit credentials [\#737](https://github.com/voxpupuli/puppet-jenkins/pull/737) ([oc243](https://github.com/oc243))
- Provide a way to override default\_plugins\_host for all plugins at one time [\#727](https://github.com/voxpupuli/puppet-jenkins/pull/727) ([egouraud-claranet](https://github.com/egouraud-claranet))
- really, really fix slave auth [\#719](https://github.com/voxpupuli/puppet-jenkins/pull/719) ([jhoblitt](https://github.com/jhoblitt))
- restart jenkins master after purging plugins [\#706](https://github.com/voxpupuli/puppet-jenkins/pull/706) ([jhoblitt](https://github.com/jhoblitt))
- add purge\_plugins param to jenkins class [\#704](https://github.com/voxpupuli/puppet-jenkins/pull/704) ([jhoblitt](https://github.com/jhoblitt))
- add jenkins::default\_plugins param [\#697](https://github.com/voxpupuli/puppet-jenkins/pull/697) ([jhoblitt](https://github.com/jhoblitt))
- systemd jenkins master support on RedHat [\#694](https://github.com/voxpupuli/puppet-jenkins/pull/694) ([jhoblitt](https://github.com/jhoblitt))
- fix slave systemd support [\#692](https://github.com/voxpupuli/puppet-jenkins/pull/692) ([jhoblitt](https://github.com/jhoblitt))
- add swarm client systemd support [\#691](https://github.com/voxpupuli/puppet-jenkins/pull/691) ([jhoblitt](https://github.com/jhoblitt))
- add ::jenkins::sysconfdir parameter [\#689](https://github.com/voxpupuli/puppet-jenkins/pull/689) ([jhoblitt](https://github.com/jhoblitt))
- disable plugin pinning by default [\#688](https://github.com/voxpupuli/puppet-jenkins/pull/688) ([jhoblitt](https://github.com/jhoblitt))
- add firewall module dependency info [\#676](https://github.com/voxpupuli/puppet-jenkins/pull/676) ([vinhut](https://github.com/vinhut))
- Add support for gitlab api token credential - \#664 [\#667](https://github.com/voxpupuli/puppet-jenkins/pull/667) ([ripclawffb](https://github.com/ripclawffb))
- Add support for disabling management of Service\[jenkins\] [\#661](https://github.com/voxpupuli/puppet-jenkins/pull/661) ([rtyler](https://github.com/rtyler))
- Add swarm client args string to support multiple arguments [\#655](https://github.com/voxpupuli/puppet-jenkins/pull/655) ([rtyler](https://github.com/rtyler))
- Disable swarm unique id on slave [\#650](https://github.com/voxpupuli/puppet-jenkins/pull/650) ([mterzo](https://github.com/mterzo))
- Allow groups to be set for the jenkins-slave user [\#629](https://github.com/voxpupuli/puppet-jenkins/pull/629) ([br0ch0n](https://github.com/br0ch0n))
- Removing 'enable' statement on job.pp and job/present.pp [\#584](https://github.com/voxpupuli/puppet-jenkins/pull/584) ([zonArt](https://github.com/zonArt))
- Dynamic job configuration [\#583](https://github.com/voxpupuli/puppet-jenkins/pull/583) ([zonArt](https://github.com/zonArt))

**Fixed bugs:**

- archive type not failing on HTTP 404s [\#783](https://github.com/voxpupuli/puppet-jenkins/issues/783)
- slave password authentication broken [\#714](https://github.com/voxpupuli/puppet-jenkins/issues/714)
- Credentials plugin hard coded [\#665](https://github.com/voxpupuli/puppet-jenkins/issues/665)
- puppet\_helper.groovy throws java.lang.ClassNotFoundException: hudson.tasks.Mailer.UserProperty  [\#633](https://github.com/voxpupuli/puppet-jenkins/issues/633)
- puppet\_helper.groovy throwing error.. No such property: cred for class: Actions [\#624](https://github.com/voxpupuli/puppet-jenkins/issues/624)
- Won't install alongside puppetlabs-mysql [\#623](https://github.com/voxpupuli/puppet-jenkins/issues/623)
- uninitialized constant json when using Jenkins\_credentials provider [\#617](https://github.com/voxpupuli/puppet-jenkins/issues/617)
- `jenkins_user` experimental password setting is broken [\#499](https://github.com/voxpupuli/puppet-jenkins/issues/499)
- Ensure $::jenkins::localstatedir to Directory Breaks Filesystem's With Symlinked Mounts [\#403](https://github.com/voxpupuli/puppet-jenkins/issues/403)
- repo::debian.pp does not work with apt module \>= 2.0.0 [\#402](https://github.com/voxpupuli/puppet-jenkins/issues/402)
- Jenkins Plugin manifest are now readable since it has got some invalid byte sequence in US-ASCII [\#265](https://github.com/voxpupuli/puppet-jenkins/issues/265)
- Default INFO logging makes jenkins cli output messages that are then … [\#907](https://github.com/voxpupuli/puppet-jenkins/pull/907) ([jhooyberghs](https://github.com/jhooyberghs))
- Avoid getting plainText from null passphrase  [\#760](https://github.com/voxpupuli/puppet-jenkins/pull/760) ([vStone](https://github.com/vStone))
- Fix all require statements for files in puppet\_x [\#755](https://github.com/voxpupuli/puppet-jenkins/pull/755) ([vStone](https://github.com/vStone))
- fix multiple slave labels [\#721](https://github.com/voxpupuli/puppet-jenkins/pull/721) ([jhoblitt](https://github.com/jhoblitt))
- workaround voxpupuli/puppet-archive\#242 [\#699](https://github.com/voxpupuli/puppet-jenkins/pull/699) ([jhoblitt](https://github.com/jhoblitt))
- fix security setting idempotentance [\#698](https://github.com/voxpupuli/puppet-jenkins/pull/698) ([jhoblitt](https://github.com/jhoblitt))
- require JSON module -- rebase of \#565 [\#696](https://github.com/voxpupuli/puppet-jenkins/pull/696) ([jhoblitt](https://github.com/jhoblitt))
- Fix a typo in README - Jennkins [\#670](https://github.com/voxpupuli/puppet-jenkins/pull/670) ([roidelapluie](https://github.com/roidelapluie))
- Newer versions of parallel\_tests require Ruby 2.0 or newer [\#662](https://github.com/voxpupuli/puppet-jenkins/pull/662) ([rtyler](https://github.com/rtyler))
- Fix get\_running issue for jenkins slave [\#660](https://github.com/voxpupuli/puppet-jenkins/pull/660) ([gtorka](https://github.com/gtorka))
- Fix syntax for class load of hudson.tasks.Mailer$UserProperty [\#636](https://github.com/voxpupuli/puppet-jenkins/pull/636) ([alan-schwarzenberger](https://github.com/alan-schwarzenberger))
- Fix for groovy.lang.MissingPropertyException [\#628](https://github.com/voxpupuli/puppet-jenkins/pull/628) ([dangerfield](https://github.com/dangerfield))
- Plugins fail to install due to search false positives [\#626](https://github.com/voxpupuli/puppet-jenkins/pull/626) ([m3brown](https://github.com/m3brown))

**Closed issues:**

- jenkins cli broken with latest LTS 2.164.1 ? [\#905](https://github.com/voxpupuli/puppet-jenkins/issues/905)
- Recent Jenkins version may have broken the CLI [\#896](https://github.com/voxpupuli/puppet-jenkins/issues/896)
- Duplicated declaration [\#880](https://github.com/voxpupuli/puppet-jenkins/issues/880)
- New tag?  [\#876](https://github.com/voxpupuli/puppet-jenkins/issues/876)
- disable anonymous read when jenkins\_authorization\_strategy { 'hudson.security.FullControlOnceLoggedInAuthorizationStrategy': [\#867](https://github.com/voxpupuli/puppet-jenkins/issues/867)
- "Triage Meeting" on Monday 2018-02-19 @ 1600UTC [\#850](https://github.com/voxpupuli/puppet-jenkins/issues/850)
- Passwords aren't quoted properly in jenkins-run.erb [\#836](https://github.com/voxpupuli/puppet-jenkins/issues/836)
- Transfer to Vox Pupuli? [\#828](https://github.com/voxpupuli/puppet-jenkins/issues/828)
- Error: Invalid or corrupt jarfile /usr/lib/jenkins/jenkins-cli.jar [\#827](https://github.com/voxpupuli/puppet-jenkins/issues/827)
- A Catalog type is required. at /etc/puppetlabs/code/modules/jenkins/manifests/cli.pp:46:37 [\#826](https://github.com/voxpupuli/puppet-jenkins/issues/826)
- Release a new version in Puppet Forge [\#825](https://github.com/voxpupuli/puppet-jenkins/issues/825)
- Private key passing issue with Groovy through jenkins pipeline [\#817](https://github.com/voxpupuli/puppet-jenkins/issues/817)
- Missing dependency for `Exec['reload-jenkins']` [\#813](https://github.com/voxpupuli/puppet-jenkins/issues/813)
- jenkins service restart on each puppet run under Redhat 7 [\#807](https://github.com/voxpupuli/puppet-jenkins/issues/807)
- Module puppetlabs/transition required for Debian/Ubuntu nodes [\#799](https://github.com/voxpupuli/puppet-jenkins/issues/799)
- Replace darin/zypprepo with puppet/zypprepo [\#798](https://github.com/voxpupuli/puppet-jenkins/issues/798)
- Remove puppetlabs/apt from hard dependencies [\#786](https://github.com/voxpupuli/puppet-jenkins/issues/786)
- code deploy fails when we add mod 'rtyler-jenkins', '0.3.1' to puppetfile [\#777](https://github.com/voxpupuli/puppet-jenkins/issues/777)
- Release the software in accordance with semantic versioning [\#770](https://github.com/voxpupuli/puppet-jenkins/issues/770)
- Ensure Jenkins::slave failed. [\#769](https://github.com/voxpupuli/puppet-jenkins/issues/769)
- Prevents upgrade of puppetlabs-java module to 2.0.0 [\#767](https://github.com/voxpupuli/puppet-jenkins/issues/767)
- plugins should not reinstall themselves if they are already installed [\#766](https://github.com/voxpupuli/puppet-jenkins/issues/766)
- Commit breaks tests [\#753](https://github.com/voxpupuli/puppet-jenkins/issues/753)
- puppet\_helper.groovy uses deprecated remoting mode [\#749](https://github.com/voxpupuli/puppet-jenkins/issues/749)
- Plugin gets reinstalled and restarts Jenkins on Puppet daemon run but NOT manual run [\#748](https://github.com/voxpupuli/puppet-jenkins/issues/748)
- When running with "umask 027" /usr/lib/jenkins/jenkins-cli.jar will be unusable by others [\#744](https://github.com/voxpupuli/puppet-jenkins/issues/744)
- allow jenkins::repo to run in another stage [\#741](https://github.com/voxpupuli/puppet-jenkins/issues/741)
- Swarm 3.3 download URL doesn't exist [\#739](https://github.com/voxpupuli/puppet-jenkins/issues/739)
- The SSL certificate has expired for https://updates.jenkins-ci.org [\#726](https://github.com/voxpupuli/puppet-jenkins/issues/726)
- jenkins-slave exposes password as command argument [\#700](https://github.com/voxpupuli/puppet-jenkins/issues/700)
- Issue with puppetlabs-apt 2.3.0 [\#686](https://github.com/voxpupuli/puppet-jenkins/issues/686)
- The job xml is stored in /tmp [\#683](https://github.com/voxpupuli/puppet-jenkins/issues/683)
- Keeps want to recreate users on every run [\#682](https://github.com/voxpupuli/puppet-jenkins/issues/682)
- Successful installation/setup, unsuccessful login [\#681](https://github.com/voxpupuli/puppet-jenkins/issues/681)
- Duplicate declaration: Jenkins::Plugin\[credentials\] is already declared [\#680](https://github.com/voxpupuli/puppet-jenkins/issues/680)
- setting security is not idempotent [\#673](https://github.com/voxpupuli/puppet-jenkins/issues/673)
- 'digest\_type' default of 'sha1' is causing all plugins to install repeatedly [\#668](https://github.com/voxpupuli/puppet-jenkins/issues/668)
- puppet\_helper.groovy throws an error with unsupported credentials [\#664](https://github.com/voxpupuli/puppet-jenkins/issues/664)
- $::jenkins::libdir is undef in jenkins::cli class [\#654](https://github.com/voxpupuli/puppet-jenkins/issues/654)
- Unsuccessful Installation [\#647](https://github.com/voxpupuli/puppet-jenkins/issues/647)
- jenkins::plugins doesn't work properly with puppet 4.6.2 [\#637](https://github.com/voxpupuli/puppet-jenkins/issues/637)
- Allow virtual jenkins host [\#630](https://github.com/voxpupuli/puppet-jenkins/issues/630)
- Ability to send in swarm flags \(i.e. deleteExistingClients\) to jenkins::slave [\#616](https://github.com/voxpupuli/puppet-jenkins/issues/616)
- Authentication failed. No private key accepted. [\#602](https://github.com/voxpupuli/puppet-jenkins/issues/602)
- Experimental Resource Types not working on Java Puppetmaster \(jRuby\) [\#597](https://github.com/voxpupuli/puppet-jenkins/issues/597)
- no ordering in config\_hash [\#443](https://github.com/voxpupuli/puppet-jenkins/issues/443)
- using jenkins::job with jenkins::cli\_helper ends up in dependency loop [\#258](https://github.com/voxpupuli/puppet-jenkins/issues/258)

**Merged pull requests:**

- add output of facter command to know value of custom fact [\#916](https://github.com/voxpupuli/puppet-jenkins/pull/916) ([Dan33l](https://github.com/Dan33l))
- Allow `puppetlabs/stdlib` 6.x, `puppetlabs/java` 4.x and `puppet/archive` 4.x [\#914](https://github.com/voxpupuli/puppet-jenkins/pull/914) ([alexjfisher](https://github.com/alexjfisher))
- Update metadata for Vox Pupuli release [\#912](https://github.com/voxpupuli/puppet-jenkins/pull/912) ([pillarsdotnet](https://github.com/pillarsdotnet))
- Allow puppetlabs/apt 7.x [\#911](https://github.com/voxpupuli/puppet-jenkins/pull/911) ([dhoppe](https://github.com/dhoppe))
- Replace `merge` function with `+` [\#909](https://github.com/voxpupuli/puppet-jenkins/pull/909) ([alexjfisher](https://github.com/alexjfisher))
- split examples about error and idempotency as much as possible [\#900](https://github.com/voxpupuli/puppet-jenkins/pull/900) ([Dan33l](https://github.com/Dan33l))
- fix unreferenced variables; add puppet5/6 support [\#898](https://github.com/voxpupuli/puppet-jenkins/pull/898) ([bastelfreak](https://github.com/bastelfreak))
- Add show\_diff parameter to pass to augeas resource [\#895](https://github.com/voxpupuli/puppet-jenkins/pull/895) ([zipkid](https://github.com/zipkid))
- Replace is\_array with Puppet 4 native comparision [\#894](https://github.com/voxpupuli/puppet-jenkins/pull/894) ([baurmatt](https://github.com/baurmatt))
- Adding SLES to supported platforms [\#893](https://github.com/voxpupuli/puppet-jenkins/pull/893) ([msurato](https://github.com/msurato))
- fix puppet\_helper.groovy exception when listing users on recent jenkins versions [\#889](https://github.com/voxpupuli/puppet-jenkins/pull/889) ([jhoblitt](https://github.com/jhoblitt))
- Pass java\_cmd to start\_slave.sh \(OS X\) [\#887](https://github.com/voxpupuli/puppet-jenkins/pull/887) ([hlaf](https://github.com/hlaf))
- allow puppetlabs/stdlib 5.x [\#886](https://github.com/voxpupuli/puppet-jenkins/pull/886) ([bastelfreak](https://github.com/bastelfreak))
- Allow custom location for slave JAVA command [\#883](https://github.com/voxpupuli/puppet-jenkins/pull/883) ([esalberg](https://github.com/esalberg))
- Fix small typo in jenkins-slave-defaults.erb [\#881](https://github.com/voxpupuli/puppet-jenkins/pull/881) ([danedf](https://github.com/danedf))
- partial modulesync 1.9.2 [\#874](https://github.com/voxpupuli/puppet-jenkins/pull/874) ([bastelfreak](https://github.com/bastelfreak))
- partial modulesync 1.9.2 [\#873](https://github.com/voxpupuli/puppet-jenkins/pull/873) ([bastelfreak](https://github.com/bastelfreak))
- puppet-lint: autofix [\#872](https://github.com/voxpupuli/puppet-jenkins/pull/872) ([bastelfreak](https://github.com/bastelfreak))
- notify service containing class instead of service resource [\#871](https://github.com/voxpupuli/puppet-jenkins/pull/871) ([jhoblitt](https://github.com/jhoblitt))
- fix native type idempotency with github-oauth plugin [\#870](https://github.com/voxpupuli/puppet-jenkins/pull/870) ([jhoblitt](https://github.com/jhoblitt))
- drop EOL OSs; fix puppet version range [\#869](https://github.com/voxpupuli/puppet-jenkins/pull/869) ([bastelfreak](https://github.com/bastelfreak))
- bump lower puppet version to 4.10.0 [\#864](https://github.com/voxpupuli/puppet-jenkins/pull/864) ([bastelfreak](https://github.com/bastelfreak))
- allow camptocamp/systemd 2.X [\#859](https://github.com/voxpupuli/puppet-jenkins/pull/859) ([bastelfreak](https://github.com/bastelfreak))
- 4 more rubocop fixes [\#852](https://github.com/voxpupuli/puppet-jenkins/pull/852) ([alexjfisher](https://github.com/alexjfisher))
- RFC: Remove dead JPM code [\#849](https://github.com/voxpupuli/puppet-jenkins/pull/849) ([alexjfisher](https://github.com/alexjfisher))
- More rubocop fixes [\#848](https://github.com/voxpupuli/puppet-jenkins/pull/848) ([alexjfisher](https://github.com/alexjfisher))
- Fix all remaining auto-fixable rubocop violations [\#847](https://github.com/voxpupuli/puppet-jenkins/pull/847) ([alexjfisher](https://github.com/alexjfisher))
- Disable rubocop for okjson.rb and resync from upstream. Fix Rubocop Style/RegexpLiteral [\#845](https://github.com/voxpupuli/puppet-jenkins/pull/845) ([alexjfisher](https://github.com/alexjfisher))
- More Rubocop fixes [\#843](https://github.com/voxpupuli/puppet-jenkins/pull/843) ([alexjfisher](https://github.com/alexjfisher))
- add pending to AWSCredentialsImpl and GitLabApiTokenImpl [\#842](https://github.com/voxpupuli/puppet-jenkins/pull/842) ([TomRitserveldt](https://github.com/TomRitserveldt))
- Feature/slave tunnel [\#840](https://github.com/voxpupuli/puppet-jenkins/pull/840) ([jhooyberghs](https://github.com/jhooyberghs))
- Bugfix/dependency 813 [\#838](https://github.com/voxpupuli/puppet-jenkins/pull/838) ([jhooyberghs](https://github.com/jhooyberghs))
- \[828\] Change badge url after transferring the repo to voxpopuli [\#837](https://github.com/voxpupuli/puppet-jenkins/pull/837) ([v1v](https://github.com/v1v))
- Fixes password quoting for jenkins.run template [\#835](https://github.com/voxpupuli/puppet-jenkins/pull/835) ([tthayer](https://github.com/tthayer))
- Cleanup the .travis.yml for a modulesync [\#834](https://github.com/voxpupuli/puppet-jenkins/pull/834) ([bastelfreak](https://github.com/bastelfreak))
- drop legacy puppet version from testmatrix [\#832](https://github.com/voxpupuli/puppet-jenkins/pull/832) ([bastelfreak](https://github.com/bastelfreak))
- Fixes for 21 different rubocop cop violations [\#831](https://github.com/voxpupuli/puppet-jenkins/pull/831) ([alexjfisher](https://github.com/alexjfisher))
- VoxPupuli Migration: Fix puppet-lint, rspec-puppet example groups and start rubocop migration [\#830](https://github.com/voxpupuli/puppet-jenkins/pull/830) ([alexjfisher](https://github.com/alexjfisher))
- bump dependency on camptocamp/systemd [\#822](https://github.com/voxpupuli/puppet-jenkins/pull/822) ([costela](https://github.com/costela))
- Add missing dependency to the gitlab plugin \(credentials\) test [\#820](https://github.com/voxpupuli/puppet-jenkins/pull/820) ([vStone](https://github.com/vStone))
- GitLab, AWS, and File credentials [\#815](https://github.com/voxpupuli/puppet-jenkins/pull/815) ([danzilio](https://github.com/danzilio))
- change namespace from PuppetX::Jenkins -\> Puppet::X::Jenkins [\#806](https://github.com/voxpupuli/puppet-jenkins/pull/806) ([jhoblitt](https://github.com/jhoblitt))
- change zypprepo dependency to voxpupuli [\#805](https://github.com/voxpupuli/puppet-jenkins/pull/805) ([jhoblitt](https://github.com/jhoblitt))
- Remove dependencies section from README. [\#804](https://github.com/voxpupuli/puppet-jenkins/pull/804) ([jhoblitt](https://github.com/jhoblitt))
- allow newer puppet-archive versions [\#803](https://github.com/voxpupuli/puppet-jenkins/pull/803) ([mmoll](https://github.com/mmoll))
- allow newer puppetlabs-apt versions [\#802](https://github.com/voxpupuli/puppet-jenkins/pull/802) ([mmoll](https://github.com/mmoll))
- allow newer puppetlabs-java version [\#801](https://github.com/voxpupuli/puppet-jenkins/pull/801) ([mmoll](https://github.com/mmoll))
- fix archive type not failing on HTTP 404s [\#795](https://github.com/voxpupuli/puppet-jenkins/pull/795) ([jhoblitt](https://github.com/jhoblitt))
- Switch repositories to HTTPs to take advantage of end-to-end TLS [\#794](https://github.com/voxpupuli/puppet-jenkins/pull/794) ([jhoblitt](https://github.com/jhoblitt))
- Replace legacy validate\_\* calls with puppet4 datatypes [\#793](https://github.com/voxpupuli/puppet-jenkins/pull/793) ([jhoblitt](https://github.com/jhoblitt))
- remove jenkins plugin dir before upgrade [\#792](https://github.com/voxpupuli/puppet-jenkins/pull/792) ([jhoblitt](https://github.com/jhoblitt))
- update travis matrix [\#790](https://github.com/voxpupuli/puppet-jenkins/pull/790) ([jhoblitt](https://github.com/jhoblitt))
- bump stdlib min version to 4.18.0 [\#789](https://github.com/voxpupuli/puppet-jenkins/pull/789) ([jhoblitt](https://github.com/jhoblitt))
- add rake shellcheck target [\#788](https://github.com/voxpupuli/puppet-jenkins/pull/788) ([jhoblitt](https://github.com/jhoblitt))
- Support null passphrase when fetching credential\_info [\#778](https://github.com/voxpupuli/puppet-jenkins/pull/778) ([anne23](https://github.com/anne23))
- Fix '-remoting' flag tests [\#775](https://github.com/voxpupuli/puppet-jenkins/pull/775) ([alvin-huang](https://github.com/alvin-huang))
- Add archlinux support [\#773](https://github.com/voxpupuli/puppet-jenkins/pull/773) ([kBite](https://github.com/kBite))
- Restore archive require [\#763](https://github.com/voxpupuli/puppet-jenkins/pull/763) ([madAndroid](https://github.com/madAndroid))
- \(documentation\) \[ci skip\]: minor typo affecting markdown rendering of jenkins\_job [\#762](https://github.com/voxpupuli/puppet-jenkins/pull/762) ([crayfishx](https://github.com/crayfishx))
- travis matrix update [\#758](https://github.com/voxpupuli/puppet-jenkins/pull/758) ([jhoblitt](https://github.com/jhoblitt))
- Correct all arrow alignments using puppet-lint [\#756](https://github.com/voxpupuli/puppet-jenkins/pull/756) ([vStone](https://github.com/vStone))
- add support for new CLI interface \(remoting is deprecated\) [\#752](https://github.com/voxpupuli/puppet-jenkins/pull/752) ([elconas](https://github.com/elconas))
- Added legacy functionality when using the `-s` flag in the jenkins cli [\#751](https://github.com/voxpupuli/puppet-jenkins/pull/751) ([darioatbashton](https://github.com/darioatbashton))
- Remove doc string for unused java\_version param [\#735](https://github.com/voxpupuli/puppet-jenkins/pull/735) ([christek91](https://github.com/christek91))
- update update-center base URL [\#728](https://github.com/voxpupuli/puppet-jenkins/pull/728) ([jhoblitt](https://github.com/jhoblitt))
- lint [\#722](https://github.com/voxpupuli/puppet-jenkins/pull/722) ([PascalBourdier](https://github.com/PascalBourdier))
- gem updates - leftovers from \#713 [\#717](https://github.com/voxpupuli/puppet-jenkins/pull/717) ([jhoblitt](https://github.com/jhoblitt))
- fix slave auth broken by \#710 [\#715](https://github.com/voxpupuli/puppet-jenkins/pull/715) ([jhoblitt](https://github.com/jhoblitt))
- assorted gem updates, cleanups, and/or removals [\#713](https://github.com/voxpupuli/puppet-jenkins/pull/713) ([jhoblitt](https://github.com/jhoblitt))
- change apt module \>= 2.1.0 [\#711](https://github.com/voxpupuli/puppet-jenkins/pull/711) ([jhoblitt](https://github.com/jhoblitt))
- do not expose slave password in process table [\#710](https://github.com/voxpupuli/puppet-jenkins/pull/710) ([jhoblitt](https://github.com/jhoblitt))
- initial puppet strings doc format conversion [\#709](https://github.com/voxpupuli/puppet-jenkins/pull/709) ([jhoblitt](https://github.com/jhoblitt))
- fix acceptance tests on Debian [\#707](https://github.com/voxpupuli/puppet-jenkins/pull/707) ([jhoblitt](https://github.com/jhoblitt))
- tidy up beaker nodesets [\#695](https://github.com/voxpupuli/puppet-jenkins/pull/695) ([jhoblitt](https://github.com/jhoblitt))
- swarm update [\#690](https://github.com/voxpupuli/puppet-jenkins/pull/690) ([jhoblitt](https://github.com/jhoblitt))
- fix exclusion of puppet 3.x / ruby 2.2 [\#687](https://github.com/voxpupuli/puppet-jenkins/pull/687) ([jhoblitt](https://github.com/jhoblitt))
- update travis test matrix [\#685](https://github.com/voxpupuli/puppet-jenkins/pull/685) ([jhoblitt](https://github.com/jhoblitt))
- allow newline before start of private key [\#657](https://github.com/voxpupuli/puppet-jenkins/pull/657) ([rtyler](https://github.com/rtyler))
- Improve credentials definition idempotency [\#656](https://github.com/voxpupuli/puppet-jenkins/pull/656) ([rtyler](https://github.com/rtyler))
- Avoid "Undefined variable 'proxy\_server'" warnings. [\#648](https://github.com/voxpupuli/puppet-jenkins/pull/648) ([jgreen210](https://github.com/jgreen210))
- bump travis puppet version matrix [\#645](https://github.com/voxpupuli/puppet-jenkins/pull/645) ([jhoblitt](https://github.com/jhoblitt))
- resolve incompatible beaker related gem versions [\#644](https://github.com/voxpupuli/puppet-jenkins/pull/644) ([jhoblitt](https://github.com/jhoblitt))
- Fixes apt module deprecation warnings [\#458](https://github.com/voxpupuli/puppet-jenkins/pull/458) ([vStone](https://github.com/vStone))

## [v1.7.0](https://github.com/voxpupuli/puppet-jenkins/tree/v1.7.0) (2016-08-18)

[Full Changelog](https://github.com/voxpupuli/puppet-jenkins/compare/v1.6.1...v1.7.0)

**Implemented enhancements:**

- Update jenkins::slave::labels to be an array. [\#572](https://github.com/voxpupuli/puppet-jenkins/issues/572)
- jenkins\_job unable to pretech jobs contained in folders [\#541](https://github.com/voxpupuli/puppet-jenkins/issues/541)
- Missing proxy support for jenkins::slave [\#442](https://github.com/voxpupuli/puppet-jenkins/issues/442)
- puppet module conflict with camptocamp/archive [\#427](https://github.com/voxpupuli/puppet-jenkins/issues/427)
- validate all DSL class/define params [\#392](https://github.com/voxpupuli/puppet-jenkins/issues/392)
- Credential types [\#373](https://github.com/voxpupuli/puppet-jenkins/issues/373)
- Jenkins::Slave wget needs proxy configuration [\#248](https://github.com/voxpupuli/puppet-jenkins/issues/248)
- Update plugin if it already installed [\#11](https://github.com/voxpupuli/puppet-jenkins/issues/11)
- jenkins 2.x support [\#611](https://github.com/voxpupuli/puppet-jenkins/pull/611) ([jhoblitt](https://github.com/jhoblitt))
- -- \#573: Convert jenkins::slave::java\_args to support both strings and arrays. [\#604](https://github.com/voxpupuli/puppet-jenkins/pull/604) ([madelaney](https://github.com/madelaney))
- Escape +'s when grepping through jenkins plugin version numbers [\#599](https://github.com/voxpupuli/puppet-jenkins/pull/599) ([cliff-svt](https://github.com/cliff-svt))
- -- \#572: Converted the jenkins slave labels param to accept a string … [\#591](https://github.com/voxpupuli/puppet-jenkins/pull/591) ([madelaney](https://github.com/madelaney))
- rubocop [\#552](https://github.com/voxpupuli/puppet-jenkins/pull/552) ([jhoblitt](https://github.com/jhoblitt))
- allow master + swarm client to coexist on the same node [\#545](https://github.com/voxpupuli/puppet-jenkins/pull/545) ([jhoblitt](https://github.com/jhoblitt))
- multiple jenkins\_job type improvements [\#544](https://github.com/voxpupuli/puppet-jenkins/pull/544) ([jhoblitt](https://github.com/jhoblitt))
- make jenkins\_job type cloudbees-folder aware [\#540](https://github.com/voxpupuli/puppet-jenkins/pull/540) ([jhoblitt](https://github.com/jhoblitt))
- add StringCredentialsImpl support to jenkins\_credentials [\#531](https://github.com/voxpupuli/puppet-jenkins/pull/531) ([jhoblitt](https://github.com/jhoblitt))
- bump swarm plugin/client versions to 2.0 [\#528](https://github.com/voxpupuli/puppet-jenkins/pull/528) ([jhoblitt](https://github.com/jhoblitt))
- use puppet/archive for all file downloads [\#516](https://github.com/voxpupuli/puppet-jenkins/pull/516) ([jhoblitt](https://github.com/jhoblitt))
- add rspec runtime profiling and .travis.yml linting [\#515](https://github.com/voxpupuli/puppet-jenkins/pull/515) ([jhoblitt](https://github.com/jhoblitt))
- Adds Beaker docker testing to .travis.yml [\#503](https://github.com/voxpupuli/puppet-jenkins/pull/503) ([petems](https://github.com/petems))
- Use Active Directory realm as type [\#495](https://github.com/voxpupuli/puppet-jenkins/pull/495) ([danielpalstra](https://github.com/danielpalstra))
- Add support for prefix configuration in the CLI config class. [\#494](https://github.com/voxpupuli/puppet-jenkins/pull/494) ([danielpalstra](https://github.com/danielpalstra))
- add ability to set java\_args on slaves [\#485](https://github.com/voxpupuli/puppet-jenkins/pull/485) ([adamcstephens](https://github.com/adamcstephens))
- An augeas helper define to deal with configs [\#480](https://github.com/voxpupuli/puppet-jenkins/pull/480) ([vStone](https://github.com/vStone))
- Add ensure=\>file to pinning file [\#475](https://github.com/voxpupuli/puppet-jenkins/pull/475) ([alexjfisher](https://github.com/alexjfisher))
- validate all class/define params [\#473](https://github.com/voxpupuli/puppet-jenkins/pull/473) ([jhoblitt](https://github.com/jhoblitt))
- Support FileCredentialsImpl in jenkins\_credentials native type [\#467](https://github.com/voxpupuli/puppet-jenkins/pull/467) ([matez](https://github.com/matez))
- Allow the user to manage the localstatedir themselves. [\#407](https://github.com/voxpupuli/puppet-jenkins/pull/407) ([jniesen](https://github.com/jniesen))
- Add manage\_client\_jar option [\#307](https://github.com/voxpupuli/puppet-jenkins/pull/307) ([bigon](https://github.com/bigon))

**Fixed bugs:**

- jenkins-slave don't stop correctly [\#557](https://github.com/voxpupuli/puppet-jenkins/issues/557)
- jenkins\_job broken by org.jenkinsci.plugins.workflow.job.WorkflowJob jobs [\#551](https://github.com/voxpupuli/puppet-jenkins/issues/551)
- Parameter jenkins::slave::ui\_pass not enclosed in quotes. [\#542](https://github.com/voxpupuli/puppet-jenkins/issues/542)
- ::jenkins::slave should not depend on ::jenkins [\#533](https://github.com/voxpupuli/puppet-jenkins/issues/533)
- slow unit test causing travis failures [\#517](https://github.com/voxpupuli/puppet-jenkins/issues/517)
- jenkins:plugin can incorrectly believe a plugin is installed \(when it isn't\) [\#513](https://github.com/voxpupuli/puppet-jenkins/issues/513)
- jenkins::plugin ignores version changes [\#512](https://github.com/voxpupuli/puppet-jenkins/issues/512)
- swarm client installation broken by bad TLS certificate [\#507](https://github.com/voxpupuli/puppet-jenkins/issues/507)
- Jenkins::Slave/Exec\[get\_swarm\_client\] is not idempotent [\#505](https://github.com/voxpupuli/puppet-jenkins/issues/505)
- Experimental types do not have support for Puppet enterprise [\#498](https://github.com/voxpupuli/puppet-jenkins/issues/498)
- Bug when it tries puppet-jenkins tries to create a user [\#476](https://github.com/voxpupuli/puppet-jenkins/issues/476)
- plugins\_dir and job\_dir don't default correctly [\#474](https://github.com/voxpupuli/puppet-jenkins/issues/474)
- Core plugins won't upgrade [\#465](https://github.com/voxpupuli/puppet-jenkins/issues/465)
- Systemd causes puppet idempotency issues [\#447](https://github.com/voxpupuli/puppet-jenkins/issues/447)
- Error: Could not find a suitable provider for jenkins\_authorization\_strategy [\#434](https://github.com/voxpupuli/puppet-jenkins/issues/434)
- port parameter ignored [\#214](https://github.com/voxpupuli/puppet-jenkins/issues/214)
- jenkins::proxy host options need to be documented [\#108](https://github.com/voxpupuli/puppet-jenkins/issues/108)
- Fix tool\_locations bash via doublequotes [\#614](https://github.com/voxpupuli/puppet-jenkins/pull/614) ([br0ch0n](https://github.com/br0ch0n))
- travis performance and acceptance test reliability improvements [\#613](https://github.com/voxpupuli/puppet-jenkins/pull/613) ([jhoblitt](https://github.com/jhoblitt))
- add 'proxy\_server' param to jenkins::slave class [\#612](https://github.com/voxpupuli/puppet-jenkins/pull/612) ([jhoblitt](https://github.com/jhoblitt))
- 5th parameter is server list for ActiveDirectory [\#564](https://github.com/voxpupuli/puppet-jenkins/pull/564) ([cdenneen](https://github.com/cdenneen))
- Fix path LOCK\_FILE [\#562](https://github.com/voxpupuli/puppet-jenkins/pull/562) ([caiohasouza](https://github.com/caiohasouza))
- test if job class responds to \#isDisabled in job\_list\_json [\#554](https://github.com/voxpupuli/puppet-jenkins/pull/554) ([jhoblitt](https://github.com/jhoblitt))
- attempt to determine the correct gem provider [\#530](https://github.com/voxpupuli/puppet-jenkins/pull/530) ([jhoblitt](https://github.com/jhoblitt))
- Dependency correction when manage\_slave\_user is false [\#523](https://github.com/voxpupuli/puppet-jenkins/pull/523) ([james-powis](https://github.com/james-powis))
- cleanup existing plugin archive if extension changes [\#519](https://github.com/voxpupuli/puppet-jenkins/pull/519) ([jhoblitt](https://github.com/jhoblitt))
- Plugins from updatecenter performance fixes [\#518](https://github.com/voxpupuli/puppet-jenkins/pull/518) ([petems](https://github.com/petems))
- fix plugin install logic matching [\#514](https://github.com/voxpupuli/puppet-jenkins/pull/514) ([jhoblitt](https://github.com/jhoblitt))
- Revert the parts of 00a90d4d that make no sense \(fixes \#474\) \(2nd attempt\) [\#483](https://github.com/voxpupuli/puppet-jenkins/pull/483) ([vStone](https://github.com/vStone))
- Fix for the jenkins.rb facter error [\#471](https://github.com/voxpupuli/puppet-jenkins/pull/471) ([jhoblitt](https://github.com/jhoblitt))
- Updated for RedHat systemd systems to use redhat provider until PUP-5353 is fixed [\#470](https://github.com/voxpupuli/puppet-jenkins/pull/470) ([cdenneen](https://github.com/cdenneen))

**Closed issues:**

- Archive module doesn't have parameter source [\#620](https://github.com/voxpupuli/puppet-jenkins/issues/620)
- support jenkins 2.x [\#603](https://github.com/voxpupuli/puppet-jenkins/issues/603)
- jenkins::credentials is not working with credentials plugin \> version 1.24 [\#601](https://github.com/voxpupuli/puppet-jenkins/issues/601)
- Forge release cycle [\#594](https://github.com/voxpupuli/puppet-jenkins/issues/594)
- Beaker tests failing, is it a plan to fix them ? [\#588](https://github.com/voxpupuli/puppet-jenkins/issues/588)
- Can't create jobs/creds/plugins after LDAP auth [\#581](https://github.com/voxpupuli/puppet-jenkins/issues/581)
- Facter 3.1 no longer has osfamily, operatingsystemrelease, operatingsystemmajrelease [\#571](https://github.com/voxpupuli/puppet-jenkins/issues/571)
- Dependency issues [\#563](https://github.com/voxpupuli/puppet-jenkins/issues/563)
- jenkins-cli puppet\_helper not working with FullControlOnceLoggedInAuthorizationStrategy [\#561](https://github.com/voxpupuli/puppet-jenkins/issues/561)
- Installing plugins fails jenkins-bootstrap-start [\#558](https://github.com/voxpupuli/puppet-jenkins/issues/558)
- Sauce labs Credentials [\#538](https://github.com/voxpupuli/puppet-jenkins/issues/538)
- Credit [\#525](https://github.com/voxpupuli/puppet-jenkins/issues/525)
- update swarm plugin + client jar to 2.0 [\#522](https://github.com/voxpupuli/puppet-jenkins/issues/522)
- Remove 1.9.3 tests [\#509](https://github.com/voxpupuli/puppet-jenkins/issues/509)
- The homedir is different on CentOS7 [\#493](https://github.com/voxpupuli/puppet-jenkins/issues/493)
- The metadata.json does not contain java as dependency [\#492](https://github.com/voxpupuli/puppet-jenkins/issues/492)
- PR \#467 broke puppet\_cli\_helper [\#477](https://github.com/voxpupuli/puppet-jenkins/issues/477)
- jenkins::plugin incorrectly assumes port 80 on puppet apply [\#457](https://github.com/voxpupuli/puppet-jenkins/issues/457)
- rtyler-jenkins fails to respect install\_java =\> false [\#455](https://github.com/voxpupuli/puppet-jenkins/issues/455)
- How does one insert private key contents directly into private\_key\_or\_path in jenkins::credentials? [\#452](https://github.com/voxpupuli/puppet-jenkins/issues/452)
- Module is missing the Jenkins configuation part [\#451](https://github.com/voxpupuli/puppet-jenkins/issues/451)
- "No checksum for this archive" when installing plugins [\#450](https://github.com/voxpupuli/puppet-jenkins/issues/450)
- Installation fail on Ubuntu Wily [\#449](https://github.com/voxpupuli/puppet-jenkins/issues/449)
- Plugins specified by version number are not updated [\#445](https://github.com/voxpupuli/puppet-jenkins/issues/445)
- Passing an array to jenkins::plugin [\#429](https://github.com/voxpupuli/puppet-jenkins/issues/429)
- Unable to persist firewall rules: Execution of '/usr/libexec/iptables/iptables.init save' returned 1: [\#424](https://github.com/voxpupuli/puppet-jenkins/issues/424)
- $::jenkins::port does not properly manage listening port [\#416](https://github.com/voxpupuli/puppet-jenkins/issues/416)
- Using Plugin Hash Exec Test for plugin Fails [\#410](https://github.com/voxpupuli/puppet-jenkins/issues/410)
- jenkins::job::present issue [\#409](https://github.com/voxpupuli/puppet-jenkins/issues/409)
- Using Direct URL for plug-ins restarts jenkins with every puppet run [\#408](https://github.com/voxpupuli/puppet-jenkins/issues/408)
- Missleading documentation regarding HTTP\_PORT [\#263](https://github.com/voxpupuli/puppet-jenkins/issues/263)

**Merged pull requests:**

- Update metadata.json for the 1.7.0 release [\#625](https://github.com/voxpupuli/puppet-jenkins/pull/625) ([rtyler](https://github.com/rtyler))
- Pin the loose dependency \(from hiera\) on json\_pure to something less than 2.0.2 [\#622](https://github.com/voxpupuli/puppet-jenkins/pull/622) ([rtyler](https://github.com/rtyler))
- Use a up-to-date swarm client URL [\#621](https://github.com/voxpupuli/puppet-jenkins/pull/621) ([rtyler](https://github.com/rtyler))
- attempt to debug travis beaker failures [\#615](https://github.com/voxpupuli/puppet-jenkins/pull/615) ([jhoblitt](https://github.com/jhoblitt))
- rubocop update [\#607](https://github.com/voxpupuli/puppet-jenkins/pull/607) ([jhoblitt](https://github.com/jhoblitt))
- fix rubocop conf path syntax warning [\#586](https://github.com/voxpupuli/puppet-jenkins/pull/586) ([jhoblitt](https://github.com/jhoblitt))
- remove README reference to nanliu/staging [\#585](https://github.com/voxpupuli/puppet-jenkins/pull/585) ([jhoblitt](https://github.com/jhoblitt))
- Updating documentation to reflect the modification of puppet-archive module [\#582](https://github.com/voxpupuli/puppet-jenkins/pull/582) ([zonArt](https://github.com/zonArt))
- Kludge around jenkins 2.x landing in the 'latest' repos [\#576](https://github.com/voxpupuli/puppet-jenkins/pull/576) ([jhoblitt](https://github.com/jhoblitt))
- use single quotes for ruby string literals [\#553](https://github.com/voxpupuli/puppet-jenkins/pull/553) ([jhoblitt](https://github.com/jhoblitt))
- replace centos-7-docker fakesystemd with classic flavor [\#550](https://github.com/voxpupuli/puppet-jenkins/pull/550) ([jhoblitt](https://github.com/jhoblitt))
- travis puppet versions [\#549](https://github.com/voxpupuli/puppet-jenkins/pull/549) ([jhoblitt](https://github.com/jhoblitt))
- fix beaker acceptance tests on Ubuntu [\#548](https://github.com/voxpupuli/puppet-jenkins/pull/548) ([jhoblitt](https://github.com/jhoblitt))
- simplify ::jenkins::slave ordering logic [\#547](https://github.com/voxpupuli/puppet-jenkins/pull/547) ([jhoblitt](https://github.com/jhoblitt))
- skip pending beaker tests [\#546](https://github.com/voxpupuli/puppet-jenkins/pull/546) ([jhoblitt](https://github.com/jhoblitt))
- minor puppet\_helper.groovy cleanup [\#543](https://github.com/voxpupuli/puppet-jenkins/pull/543) ([jhoblitt](https://github.com/jhoblitt))
- Improve spec speed [\#537](https://github.com/voxpupuli/puppet-jenkins/pull/537) ([petems](https://github.com/petems))
- make centos-6-docker acceptance tests required [\#527](https://github.com/voxpupuli/puppet-jenkins/pull/527) ([jhoblitt](https://github.com/jhoblitt))
- Add folder support to puppet\_helper [\#496](https://github.com/voxpupuli/puppet-jenkins/pull/496) ([danielpalstra](https://github.com/danielpalstra))
- enable install of cli\_helper when jenkins::cli =\> true [\#488](https://github.com/voxpupuli/puppet-jenkins/pull/488) ([jhoblitt](https://github.com/jhoblitt))
- autorequire cli\_jar from all PX::J::Type::Cli based types [\#486](https://github.com/voxpupuli/puppet-jenkins/pull/486) ([jhoblitt](https://github.com/jhoblitt))
- Revert "Support FileCredentialsImpl in jenkins\_credentials native type" [\#478](https://github.com/voxpupuli/puppet-jenkins/pull/478) ([jhoblitt](https://github.com/jhoblitt))
- Rtyler 417 cleanup cli helper [\#469](https://github.com/voxpupuli/puppet-jenkins/pull/469) ([jhoblitt](https://github.com/jhoblitt))
- Clarify documention for cli\_ssh\_keyfile param. [\#446](https://github.com/voxpupuli/puppet-jenkins/pull/446) ([BobVincentatNCRdotcom](https://github.com/BobVincentatNCRdotcom))
- travis does not need the :system\_tests group [\#438](https://github.com/voxpupuli/puppet-jenkins/pull/438) ([jhoblitt](https://github.com/jhoblitt))
- Minor clean up of difftool patch [\#430](https://github.com/voxpupuli/puppet-jenkins/pull/430) ([rtyler](https://github.com/rtyler))
- Suppress notice messages when using archive::download [\#428](https://github.com/voxpupuli/puppet-jenkins/pull/428) ([queeno](https://github.com/queeno))
- Add a simple rspec-puppet test to verify changing jenkins::plugin's timeout [\#421](https://github.com/voxpupuli/puppet-jenkins/pull/421) ([rtyler](https://github.com/rtyler))
- Fix Plugin Download Timeout [\#419](https://github.com/voxpupuli/puppet-jenkins/pull/419) ([mooreandrew](https://github.com/mooreandrew))
- Unify the ssh\_keyfile [\#417](https://github.com/voxpupuli/puppet-jenkins/pull/417) ([chizou](https://github.com/chizou))
- Check if the retries gem is not already declared [\#411](https://github.com/voxpupuli/puppet-jenkins/pull/411) ([boyand](https://github.com/boyand))
- Undefine create\_user in plugins [\#406](https://github.com/voxpupuli/puppet-jenkins/pull/406) ([jonbca](https://github.com/jonbca))
- fix job\_dir variable reference to jenkins class [\#400](https://github.com/voxpupuli/puppet-jenkins/pull/400) ([shieldwed](https://github.com/shieldwed))

## [v1.6.1](https://github.com/voxpupuli/puppet-jenkins/tree/v1.6.1) (2015-10-14)

[Full Changelog](https://github.com/voxpupuli/puppet-jenkins/compare/v1.6.0...v1.6.1)

**Closed issues:**

- Preparing a release for PuppetConf [\#384](https://github.com/voxpupuli/puppet-jenkins/issues/384)

## v1.6.0

(Kato release)

* [#219](https://github.com/jenkinsci/puppet-jenkins/issues/219) - Plugins are installed each time and restarting service
* [#314](https://github.com/jenkinsci/puppet-jenkins/pull/314) - Update jenkins-slave.RedHat init.d script work bash < 4.0
* [#362](https://github.com/jenkinsci/puppet-jenkins/issues/362) - Error on updating existing job
* [#365](https://github.com/jenkinsci/puppet-jenkins/issues/365) - jenkins user and jenkins_home directory not configurable
* [#367](https://github.com/jenkinsci/puppet-jenkins/pull/367) - [puppet-jenkins#366] Replace -toolLocations with --toolLocation
* [#371](https://github.com/jenkinsci/puppet-jenkins/issues/371) - slave:  INFO: Failure authenticating with BASIC 'Jenkins'  401
* [#372](https://github.com/jenkinsci/puppet-jenkins/issues/372) - Slave: swarm-client requires a cashe directory /home/jenkins-slave/.jenkins/
* [#374](https://github.com/jenkinsci/puppet-jenkins/pull/374) - add single quotes for credentials
* [#376](https://github.com/jenkinsci/puppet-jenkins/pull/376) - Add template in the jenkins::job
* [#377](https://github.com/jenkinsci/puppet-jenkins/pull/377) - Making the management of the daemon package optional
* [#378](https://github.com/jenkinsci/puppet-jenkins/pull/378) - fix rspec-puppet `raise_error` warning
* [#382](https://github.com/jenkinsci/puppet-jenkins/pull/382) - (RFC) native types and providers
* [#383](https://github.com/jenkinsci/puppet-jenkins/pull/383) - fix acceptance test path prefix for jenkins-cli.jar
* [#385](https://github.com/jenkinsci/puppet-jenkins/pull/385) - WIP: completely rework the way imports work for the native types
* [#386](https://github.com/jenkinsci/puppet-jenkins/pull/386) - set_security() does not save jenkins state
* [#387](https://github.com/jenkinsci/puppet-jenkins/pull/387) - Avoid referring to class objects directly in the Groovy helper
* [#388](https://github.com/jenkinsci/puppet-jenkins/pull/388) - Fix relationship for pinned files
* [#389](https://github.com/jenkinsci/puppet-jenkins/pull/389) - remove seperate resources for handling plugin extension
* [#390](https://github.com/jenkinsci/puppet-jenkins/pull/390) - Adds Examples for various platforms for Jenkins
* [#391](https://github.com/jenkinsci/puppet-jenkins/pull/391) - use ensure_packages() to manage the daemon package
* [#395](https://github.com/jenkinsci/puppet-jenkins/pull/395) - Fix username quoting
* [#396](https://github.com/jenkinsci/puppet-jenkins/pull/396) - add user/group mgt. + localstatedir params to jenkins class
* [#398](https://github.com/jenkinsci/puppet-jenkins/pull/398) - client_url is hardcoded in slave.pp
* [#399](https://github.com/jenkinsci/puppet-jenkins/pull/399) - document types and providers puppetserver known issues

## v1.5.0

(Jennings release)

* [#227](https://github.com/jenkinsci/puppet-jenkins/pull/227) - Add parameter to set user uuid in jenkins::credentials define
* [#288](https://github.com/jenkinsci/puppet-jenkins/pull/288) - add source parameter to jenkins::plugin define
* [#289](https://github.com/jenkinsci/puppet-jenkins/pull/289) - set user on exec resources in jenkins::plugin define
* [#290](https://github.com/jenkinsci/puppet-jenkins/pull/290) - Support getting external .xml job descriptions
* [#292](https://github.com/jenkinsci/puppet-jenkins/pull/292) - Feature/puppet helper util
* [#295](https://github.com/jenkinsci/puppet-jenkins/pull/295) - Use jenkins::cli::exec in security.pp
* [#296](https://github.com/jenkinsci/puppet-jenkins/pull/296) - should be jenkins::cli::exec
* [#297](https://github.com/jenkinsci/puppet-jenkins/pull/297) - Add jenkins::users class to declare all users
* [#298](https://github.com/jenkinsci/puppet-jenkins/pull/298) - Maint/fix resource relationships
* [#301](https://github.com/jenkinsci/puppet-jenkins/pull/301) - Apt upgrade
* [#302](https://github.com/jenkinsci/puppet-jenkins/pull/302) - Package name no longer hardcoded
* [#303](https://github.com/jenkinsci/puppet-jenkins/pull/303) - Puppet helper slaveagentport
* [#319](https://github.com/jenkinsci/puppet-jenkins/pull/319) - Adding optional description to slave
* [#320](https://github.com/jenkinsci/puppet-jenkins/issues/320) - Forge Project URL link broken
* [#323](https://github.com/jenkinsci/puppet-jenkins/pull/323) - Upgraded apt module dependency to support v2
* [#325](https://github.com/jenkinsci/puppet-jenkins/pull/325) - add puppet ~> 3.8 & ~> 4.1 to travis matrix
* [#326](https://github.com/jenkinsci/puppet-jenkins/pull/326) - Fixed project_page in metadata.json
* [#328](https://github.com/jenkinsci/puppet-jenkins/pull/328) - Support configuring a yum proxy server
* [#331](https://github.com/jenkinsci/puppet-jenkins/pull/331) - Set retries in job configuration to global parameters
* [#335](https://github.com/jenkinsci/puppet-jenkins/pull/335) - Fix jenkins::plugin with create_user false
* [#336](https://github.com/jenkinsci/puppet-jenkins/pull/336) - Features/9618 stronger plugin verification
* [#347](https://github.com/jenkinsci/puppet-jenkins/pull/347) - Fix require paths
* [#351](https://github.com/jenkinsci/puppet-jenkins/pull/351) - add darwin/osx support to slave class
* [#352](https://github.com/jenkinsci/puppet-jenkins/pull/352) - Adding cli_ssh_keyfile parameter to specify the location of a private key
* [#353](https://github.com/jenkinsci/puppet-jenkins/pull/353) - Class cannot find exec in jenkins::cli::reload.
* [#357](https://github.com/jenkinsci/puppet-jenkins/issues/357) - CLI classes unaware of Jenkins' --prefix
* [#358](https://github.com/jenkinsci/puppet-jenkins/pull/358) - Added jenkins_prefix function to retrieve configured prefix


## v1.4.0

(Smithers release)

* [#222](https://github.com/jenkinsci/puppet-jenkins/pull/222) - Add retry to credentials execs
* [#229](https://github.com/jenkinsci/puppet-jenkins/pull/229) - Jenkins slave defaults bugfix
* [#233](https://github.com/jenkinsci/puppet-jenkins/pull/233) - fixes timeouts on restart
* [#235](https://github.com/jenkinsci/puppet-jenkins/pull/235) - Make creation of user optional
* [#236](https://github.com/jenkinsci/puppet-jenkins/pull/236) - Cleanup metadata.json for better mechanical score
* [#237](https://github.com/jenkinsci/puppet-jenkins/pull/237) - Update the README with a few puppet-lint things and puppet highlighting.
* [#238](https://github.com/jenkinsci/puppet-jenkins/pull/238) - Fix Bracket issue
* [#239](https://github.com/jenkinsci/puppet-jenkins/pull/239) - Refactor acceptance tests to use beaker-rspec
* [#244](https://github.com/jenkinsci/puppet-jenkins/pull/244) - Add instructions for acceptance tests
* [#245](https://github.com/jenkinsci/puppet-jenkins/pull/245) - Added support for the 'toolLocations' parameter.
* [#256](https://github.com/jenkinsci/puppet-jenkins/pull/256) - Direct package
* [#260](https://github.com/jenkinsci/puppet-jenkins/pull/260) - Feature/puppet helper num executors
* [#261](https://github.com/jenkinsci/puppet-jenkins/pull/261) - Escape job names for shell commands
* [#262](https://github.com/jenkinsci/puppet-jenkins/pull/262) - Change apt key to full fingerprint
* [#264](https://github.com/jenkinsci/puppet-jenkins/issues/264) - Broken link on puppetlabs.com page
* [#266](https://github.com/jenkinsci/puppet-jenkins/pull/266) - pin puppetlabs-apt fixtures version to 1.8.0
* [#268](https://github.com/jenkinsci/puppet-jenkins/pull/268) - Improvements on job import via cli
* [#270](https://github.com/jenkinsci/puppet-jenkins/pull/270) - remove rspec gem ~> 2.99.0 constraint
* [#271](https://github.com/jenkinsci/puppet-jenkins/pull/271) - fix rspec > 3 compatiblity
* [#272](https://github.com/jenkinsci/puppet-jenkins/pull/272) - use mainline puppetlabs_spec_helper gem
* [#273](https://github.com/jenkinsci/puppet-jenkins/pull/273) - update spec_helper_acceptance boiler plate
* [#274](https://github.com/jenkinsci/puppet-jenkins/pull/274) - remove puppet module versions constraints from beaker setup
* [#275](https://github.com/jenkinsci/puppet-jenkins/pull/275) - add .bundle to .gitignore
* [#276](https://github.com/jenkinsci/puppet-jenkins/pull/276) - add log/ to .gitignore
* [#277](https://github.com/jenkinsci/puppet-jenkins/pull/277) - add puppet 3.7.0 to travis matrix
* [#278](https://github.com/jenkinsci/puppet-jenkins/pull/278) - remove unnecessary whitespace from $::jenkins::cli_helper::helper_cmd
* [#279](https://github.com/jenkinsci/puppet-jenkins/pull/279) - add metadata-json-lint to Gemfile & enable rake validate target
* [#280](https://github.com/jenkinsci/puppet-jenkins/pull/280) - change puppetlabs/stdlib version dep to >= 4.6.0
* [#282](https://github.com/jenkinsci/puppet-jenkins/pull/282) - Feature/puppet 4
* [#285](https://github.com/jenkinsci/puppet-jenkins/pull/285) - convert raw execs of puppet_helper.groovy to jenkins::cli::exec define


## v1.3.0

(Barnard release)

* [#134](https://github.com/jenkinsci/puppet-jenkins/pull/134) - Added in ability for user to redefine update center plugin URL
* [#139](https://github.com/jenkinsci/puppet-jenkins/pull/139) - document additional class params
* [#169](https://github.com/jenkinsci/puppet-jenkins/pull/169) - Allow build jobs to be configured and managed by puppet. Includes #163 a...
* [#174](https://github.com/jenkinsci/puppet-jenkins/issues/174) - setting configure_firewall true returns error, port is undefined
* [#177](https://github.com/jenkinsci/puppet-jenkins/issues/177) - switch to metadata.json
* [#188](https://github.com/jenkinsci/puppet-jenkins/pull/188) - Fix installation of core plugins
* [#189](https://github.com/jenkinsci/puppet-jenkins/pull/189) - Fix test.
* [#191](https://github.com/jenkinsci/puppet-jenkins/pull/191) - set default port for firewall
* [#195](https://github.com/jenkinsci/puppet-jenkins/pull/195) - Bump up swarm version to 1.17
* [#198](https://github.com/jenkinsci/puppet-jenkins/issues/198) - Relationship error when testing Jenkins::jobs
* [#199](https://github.com/jenkinsci/puppet-jenkins/pull/199) - missing include causes issuse #198
* [#202](https://github.com/jenkinsci/puppet-jenkins/pull/202) - Proxy work
* [#203](https://github.com/jenkinsci/puppet-jenkins/pull/203) - Fix typo in job/present.pp
* [#204](https://github.com/jenkinsci/puppet-jenkins/pull/204) - Fix for #174 allows setting $jenkins::port
* [#206](https://github.com/jenkinsci/puppet-jenkins/issues/206) - Refactor some of the firewall port configuration
* [#207](https://github.com/jenkinsci/puppet-jenkins/pull/207) - Introduce the jenkins_port function


## v1.2.0

(Nestor release)

* [#117](https://github.com/jenkinsci/puppet-jenkins/pull/117) - Add feature to disable SSL verification on Swarm clients
* [#131](https://github.com/jenkinsci/puppet-jenkins/pull/131) - Support updates for core jenkins modules
* [#135](https://github.com/jenkinsci/puppet-jenkins/issues/135) - cli option broken w/ jenkins 1.563 on ubuntu precise
* [#137](https://github.com/jenkinsci/puppet-jenkins/pull/137) - repos should be enabled if repo=true on RedHat
* [#140](https://github.com/jenkinsci/puppet-jenkins/issues/140) - Packaging Cruft in 1.1.0
* [#144](https://github.com/jenkinsci/puppet-jenkins/pull/144) - Update init.pp - correct plugins example syntax
* [#149](https://github.com/jenkinsci/puppet-jenkins/pull/149) - Do not ensure plugin_parent_dir to be a directory (#148)
* [#150](https://github.com/jenkinsci/puppet-jenkins/pull/150) - Add ensure parameter to jenkins::slave
* [#151](https://github.com/jenkinsci/puppet-jenkins/issues/151) - Unsupported OSFamily RedHat on node
* [#152](https://github.com/jenkinsci/puppet-jenkins/issues/152) - Jenkins-slave on Centos: killproc and checkpid commands not found
* [#153](https://github.com/jenkinsci/puppet-jenkins/pull/153) - Fixes to Jenkins slave init and class
* [#154](https://github.com/jenkinsci/puppet-jenkins/issues/154) - slave_mode doesn't apply on debian distros.
* [#155](https://github.com/jenkinsci/puppet-jenkins/pull/155) - Add defined check for plugin_parent_dir resource
* [#157](https://github.com/jenkinsci/puppet-jenkins/pull/157) - Add missing slave mode to Debian defaults file
* [#160](https://github.com/jenkinsci/puppet-jenkins/pull/160) - User and credentials creation, simple security management
* [#166](https://github.com/jenkinsci/puppet-jenkins/issues/166) - Error loading fact /var/lib/puppet/lib/facter/jenkins.rb no such file to load -- json
* [#171](https://github.com/jenkinsci/puppet-jenkins/pull/171) - A bit of RedHat and Debian slave initd script merging
* [#176](https://github.com/jenkinsci/puppet-jenkins/issues/176) - no such file to load -- json
* [#180](https://github.com/jenkinsci/puppet-jenkins/issues/180) - Replace use of unzip with `jar` for unpacking jenkins CLI
* [#182](https://github.com/jenkinsci/puppet-jenkins/pull/182) - Include the apt module when installing an apt repository
* [#183](https://github.com/jenkinsci/puppet-jenkins/pull/183) - Rely on the `jar` command instead of `unzip` to unpack the cli.jar
* [#185](https://github.com/jenkinsci/puppet-jenkins/pull/185) - Allow setting the slave name, default to the fqdn at runtime
* [#186](https://github.com/jenkinsci/puppet-jenkins/issues/186) - Puppet Forge module
* [#187](https://github.com/jenkinsci/puppet-jenkins/issues/187) - Jenkins slave on RedHat - jenkins-slave.erb


## v1.1.0

(Duckworth release)

### Features

 * [#86](https://github.com/jenkinsci/puppet-jenkins/issues/86),
   [#122](https://github.com/jenkinsci/puppet-jenkins/pull/122) - Add support
   for disabling SSL verification on slaves
 * [#116](https://github.com/jenkinsci/puppet-jenkins/pull/116) - Add support
   for setting the `-fsroot` option for slaves
 * `init` script for Debian-family slaves added
 * Initial code for a [jpm](https://github.com/rtyler/jpm) based `Package`
   provider merged


### Bug fixes

 * [#107](https://github.com/jenkinsci/puppet-jenkins/pull/107) - Private/internal classes made truly private
 * [#109](https://github.com/jenkinsci/puppet-jenkins/pull/109) - Fix for
   dependency issue between repo and package installation.
 * `$jenkins_plugins` fact refactored and RSpec tests added
 * [#121](https://github.com/jenkinsci/puppet-jenkins/pull/121) - `daemon`
   package installed to make Debian slave installs functional
 * [#126](https://github.com/jenkinsci/puppet-jenkins/issues/126) - Facter
   exception bug fixed


\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
