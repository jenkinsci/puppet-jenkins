Experimental native types and providers
==

**The semantics and API of these types should be considered _unstable_ and
almost certainly will change based on feedback.  It is currently unclear if
these types will be considered part of the public API or treated as private to
the module.**


#### Table of Contents

1. [Configuration](#configuration)
    * [`puppetserver`](#puppetserver)
2. [Types](#types)
    * [`jenkins_authorization_strategy`](#jenkins_authorization_strategy)
    * [`jenkins_credentials`](#jenkins_credentials)
    * [`jenkins_job`](#jenkins_job)
    * [`jenkins_num_executors`](#jenkins_num_executors)
    * [`jenkins_security_realm`](#jenkins_security_realm)
    * [`jenkins_slaveagent_port`](#jenkins_slaveagent_port)
    * [`jenkins_user`](#jenkins_user)
3. [TODO](#todo)


Configuration
--
This family of types and providers that manages jenkins via the `cli` jar take
common configuration from the parameters of a class named
`jenkins::cli::config`.  The implementation of this class may be empty.
However, the version included in this module has provides some additional
setup.  The parameters used to override default values are:

* `cli_jar`
* `url`
* `ssh_private_key`
* `puppet_helper`
* `cli_tries`
* `cli_try_sleep`
* `cli_username`
* `cli_password`
* `cli_password_file`
* `cli_password_file_exists`

An example for a secured jenkins (e.g. ad connected) for LTS version
newer then 2.46.2 (e.g. 2.60.1)

```
class { 'jenkins::cli::config':
  cli_username      => 'puppet',
  cli_password_file => 'thisisanactivedirectorypassword',
  cli_tries         => 3,
  cli_try_sleep     => 1,
}
```

An example for a secured jenkins (e.g. ad connected) for LTS version
newer then 2.46.2 (e.g. 2.60.1) using an existing credentials file.
Note: The file /root/password_file_for_puppet with content
      username:password must already exist or be created via puppet.

```
class { 'jenkins::cli::config':
  cli_username             => 'puppet',
  cli_password_file        => '/root/password_file_for_puppet',
  cli_password_file_exists => true,
  cli_tries                => 3,
  cli_try_sleep            => 1,
}
```

An example of setting a non-default path to the ssh key used to authenticate the
`cli` with jenkins are reducing the number of retry attempts. Note: This only works
for OLD versions of jenkins.

```
class { 'jenkins::cli::config':
  ssh_private_key => '/home/vagrant/insecure_private_key',
  cli_tries       => 3,
  cli_try_sleep   => 1,
}
```

An example of setting an alternative port number and an addition of a prefix.

```
class { 'jenkins::cli::config':
  url => 'http://localhost:9999/awesome-jenkins',
}
```

These values may also be set via facts with the same name after the prefix
`jenkins_`.  Class parameters have precedence over fact values.

* `jenkins_cli_jar`
* `jenkins_url`
* `jenkins_ssh_private_key`
* `jenkins_puppet_helper`
* `jenkins_cli_tries`
* `jenkins_cli_try_sleep`

Configuration via facts is particularly convenient for testing via the `resource` face. For example:

```
export FACTER_jenkins_puppet_helper=/tmp/vagrant-puppet/modules-998ea1817cb4dea9c136a57fd18781c5/jenkins/files/puppet_helper.groov
export FACTER_jenkins_cli_tries=2
export FACTER_jenkins_ssh_private_key=/home/vagrant/insecure_private_key

puppet resource --modulepath=/tmp/vagrant-puppet/modules-998ea1817cb4dea9c136a57fd18781c5/ jenkins_user --debug --trace
```

All providers presently require `java`, the jenkins CLI jar, and the jenkins
master service to be running.  Most require the presence of
`puppet_helper.groovy`.  The following puppet code snippet will prepare a node
sufficiently for all providers to function.

```
class { '::jenkins':
  install_java => true,
  cli          => true,
}
include ::jenkins::cli_helper
```

### `puppetserver`

There is a known issue with `puppetserver` being unable to load code from
modules outside of `./lib/puppet`.  This effects all modules using the
recommended `PuppetX::<vendor>` namespace.

The work around (only required to use these new native types) is to edit
`/etc/puppetlabs/puppetserver/conf.d/puppetserver.conf` and add the "cache" dir to the `ruby-load-path` entry.  Eg.,

```
jruby-puppet: {
    ruby-load-path: [/opt/puppetlabs/puppet/lib/ruby/vendor_ruby, /opt/puppetlabs/puppet/cache/lib]
    ...
}
```

See [SERVER-973](https://tickets.puppetlabs.com/browse/SERVER-973)

Types
--

### `jenkins_authorization_strategy`

```
jenkins_authorization_strategy { '<jenkins AuthorizationStrategy class name>':
  ensure    => 'present', # present | absent
  arguments => [],        # array of arguments to class constructor
}
```

#### "Anyone can do anything"

```
jenkins_authorization_strategy { 'hudson.security.AuthorizationStrategy$Unsecured':
  ensure => 'present',
}
```

#### "Github Commiter Authorization Strategy"

Provided by the [`github-oauth`](https://wiki.jenkins-ci.org/display/JENKINS/Github+OAuth+Plugin) plugin.

```
jenkins_authorization_strategy { 'org.jenkinsci.plugins.GithubAuthorizationStrategy':
  ensure    => 'present',
  arguments => [
    'admin',
    true,
    false,
    false,
    lsst,
    false,
    false,
    false,
  ],
}
```

Order of arguments is:

* `adminUserNames`
* `authenticatedUserReadPermission`
* `useRepositoryPermissions`
* `authenticatedUserCreateJobPermission`
* `organizationNames`
* `allowGithubWebHookPermission`
* `allowCcTrayPermission`
* `allowAnonymousReadPermission`

XXX Would `arguments` be more convenient as a hash?

#### "Legacy mode"

XXX requires additional configuration???

```
jenkins_authorization_strategy { 'hudson.security.LegacyAuthorizationStrategy':
  ensure => 'present',
}
```

#### "Logged-in users can do anything"

```
jenkins_authorization_strategy { 'hudson.security.FullControlOnceLoggedInAuthorizationStrategy':
  ensure => 'present',
  }
```

#### "Matrix-based security"

XXX does not currently support configuring the access matrix -- this make it
essentially unusable as setting this strategy will lock out the cli
```
jenkins_authorization_strategy { 'hudson.security.GlobalMatrixAuthorizationStrategy':
  ensure => 'present',
}
```

#### "Project-based Matrix Authorization Strategy"

XXX same issue as `hudson.security.GlobalMatrixAuthorizationStrategy`

```
jenkins_authorization_strategy { 'hudson.security.ProjectMatrixAuthorizationStrategy':
  ensure => 'present',
}
```

#### disabling any resource name is equivalent to setting `hudson.security.AuthorizationStrategy$Unsecured`
```
jenkins_authorization_strategy { 'hudson.security.FullControlOnceLoggedInAuthorizationStrategy':
  ensure => absent
}
```

### `jenkins_credentials`

Note that unlike `jenkins::credentials` the resource name is the jenkins' `id`
instead of the credentials' `username`.  This is necessary as `username` is not
unique event within a domain and not all credentials types have a `username`
property.

```
jenkins_credentials { '<id>':
  ensure      => 'present', # present | absent
  description => 'description',
  domain      => undef,     # undef is the global domain; only allowed value
  impl        => '<jenkins credentials class short name>',
  password    => 'password',
  scope       => 'GLOBAL',  # GLOBAL | SYSTEM
  username    => 'username',
  passphrase  => '',        # currently buggy when unset
  private_key => '<ssh private key as string>',
}
```

* `impl`

* `UsernamePasswordCredentialsImpl`
* `BasicSSHUserPrivateKey`
* `StringCredentialsImpl`
* `FileCredentialsImpl`
* `AWSCredentialsImpl`
* `ConduitCredentialsImpl`
* `GitLabApiTokenImpl`

XXX This type has properties for other credentials classes that are not currently supported.


#### `UsernamePasswordCredentialsImpl`

```
jenkins_credentials { 'my unique id':
  ensure      => 'present',
  description => 'account info for user bar',
  domain      => 'undef',
  impl        => 'UsernamePasswordCredentialsImpl',
  password    => 'password',
  scope       => 'GLOBAL',
  username    => 'bar',
}
```

#### `BasicSSHUserPrivateKey`

```
jenkins_credentials { 'a0469025-1202-4007-983d-0c62f230f1a7':
  ensure      => 'present',
  description => 'ssh key for user foo',
  domain      => undef,
  impl        => 'BasicSSHUserPrivateKey',
  passphrase  => '',
  private_key => '-----BEGIN RSA PRIVATE KEY----- ...',
  scope       => 'GLOBAL',
  username    => 'foo',
}
```

#### `StringCredentialsImpl`

Using this credential type requires that the jenkins `plain-credentials` plugin
has been installed.

```
jenkins_credentials { '150b2895-b0eb-4813-b8a5-3779690c063c':
  ensure      => 'present',
  description => 'secret string',
  domain      => undef,
  impl        => 'StringCredentialsImpl',
  scope       => 'SYSTEM',
  secret      => '42',
}
```

#### `FileCredentialsImpl`

Using this credential type requires that the jenkins `plain-credentials` plugin
has been installed.

```
jenkins_credentials { '95bfe159-8bf0-4605-be20-47e201220e7c':
  ensure      => 'present',
  description => 'secret file with very secret data',
  domain      => undef,
  impl        => 'FileCredentialsImpl',
  scope       => 'GLOBAL',
  file_name   => 'foo.bar',
  content     => 'secret data on 1st line\nsecret data on 2nd line'
}
```

#### `AWSCredentialsImpl`

Using this credential type requires that the jenkins `aws-credentials` plugin
has been installed.

```
jenkins_credentials { '34d75c64-61ff-4a28-bd40-cac3aafc7e3a':
  ensure      => 'present',
  description => 'aws credential',
  impl        => 'AWSCredentialsImpl',
  access_key  => 'much access',
  secret_key  => 'many secret',
}
```

### `ConduitCredentialsImpl`

```
jenkins_credentials { '002224bd-60cb-49f3-a314-d0f73f82233d':
  ensure      => 'present',
  description => 'phabricator-jenkins-conduit',
  domain      => undef,
  impl        => 'ConduitCredentialsImpl',
  token       => '{PRIVATE TOKEN}',
  url         => 'https://my-phabricator-repo.com',
}
```

### `GitLabApiTokenImpl`

```
jenkins_credentials { '7e86e9fb-a8af-480f-b596-7191dc02bf38':
  ensure      => 'present',
  description => 'GitLab API token',
  impl        => 'GitLabApiTokenImpl',
  api_token   => 'tokens for days',
}
```

### `jenkins_job`

```
jenkins_job { 'job name':
  ensure    => 'present', # present | absent
  enable    => true, # true | false
  config    => '<xml config string>',
  show_diff => true, # true | false
}
```

Has basic support for the `cloudbees-folder` plugin including automatically
ordering parent folders before nested jobs.

XXX Note that enable is prefetched correctly but the value is ignored when
syncing.

```
jenkins_job { 'myjob':
  ensure => 'present',
  config => '<?xml version="1.0" encoding="UTF-8"?><project>
  <actions/>
  <description/>
  <keepDependencies>false</keepDependencies>
  <properties>
    <com.sonyericsson.rebuild.RebuildSettings plugin="rebuild@1.25">
      <autoRebuild>false</autoRebuild>
      <rebuildDisabled>false</rebuildDisabled>
    </com.sonyericsson.rebuild.RebuildSettings>
  </properties>
  <scm class="hudson.scm.NullSCM"/>
  <canRoam>true</canRoam>
  <disabled>false</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <triggers/>
  <concurrentBuild>false</concurrentBuild>
  <builders/>
  <publishers/>
  <buildWrappers/>
</project>',
  enable => true,
}
```

### `jenkins_num_executors`

```
jenkins_num_executors { 42: # name is coerced to Integer
  ensure => 'present', # present is the only allowed value
}
```

XXX Note that it is possible to declare this resource multiple times.  Each
instance will set the value.

### `jenkins_security_realm`


#### "Delegate to servlet container"

```
jenkins_security_realm { 'hudson.security.LegacySecurityRealm':
  ensure => 'present',
}
```

#### "Github Authentication Plugin"

Provided by the [`github-oauth`](https://wiki.jenkins-ci.org/display/JENKINS/Github+OAuth+Plugin) plugin.

```
jenkins_security_realm { 'org.jenkinsci.plugins.GithubSecurityRealm':
  ensure    => 'present',
  arguments => [
    'https://github.com',
    'https://api.github.com',
    'c4d1...',
    'a4ca...',
    'repo,read:org',
  ],
}
```

Order of arguments is:

* `githubWebUri`
* `githubApiUri`
* `clientID`
* `clientSecret`
* `oauthScopes`

#### "Jenkins’ own user database"

```
jenkins_security_realm { 'hudson.security.HudsonPrivateSecurityRealm':
  ensure    => 'present',
  arguments => [true, false, undef],
}
```

Order of arguments is:

* allowSignup
* enableCaptcha
* <always undef>

#### "LDAP"

__unsupported__

#### "Unix user/group database"

```
jenkins_security_realm { 'hudson.security.PAMSecurityRealm':
  ensure    => 'present',
  arguments => ['sshd'], # service name
}
```

### `jenkins_slaveagent_port`

```
jenkins_slaveagent_port { 44444: # name is coerced to Integer
  ensure => 'present', # present is the only allowed value
}
```

XXX Note that it is possible to declare this resource multiple times.  Each
instance will set the value.

### `jenkins_user`

```
jenkins_user { 'admin':
  ensure           => 'present',
  api_token_plain  => '29fedb889e8ccf649bfdada5d9e8c519',
  api_token_public => '03b99b3d93a5dc6193dbe7d97acaa0a6',
  email_address    => 'foo@example.org',
  full_name        => 'jenkins admin',
  password         => '#jbcrypt:$2a$10$wFyDgWYOHauojVfxiXWD3OTJMt6vE.j6eJol8uYMdZ5JrZ2lj9xny',
  public_keys      => ['ssh-rsa AAAA...'],
}
```

* `api_token_public`

A _read-only_ property; jenkins does not support setting the token

* `api_token_plain`

The jenkins internal only value that is hashed to produce the public API token.
This value can be set for a user by violating a private interface.  This value
may be discovered by using the puppet resource face.

* `password`

May be a plain string but this will be non-idempotent.  The hash string value
may be discovered with the puppet resource face.


TODO
--

* beaker/acceptance tests that exercise all types/providers

* integrate types with existing DSL defined types

* determine if these types should be a "public interface" or considered private
  to the module

* rename some of the new `puppet_helper.groovy` methods for consistency and add
  descriptive comments to all methods

* determine what to do about `jenkins_job` `enable` parameter which potentially
  breaks idempotency

* test that the transition from authentication being required to disabled is
  properly handled

* fix `jenkins_credentials` handling of a blank `passphrase` for
  `BasicSSHUserPrivateKey`
