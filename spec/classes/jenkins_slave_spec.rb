require 'spec_helper'

describe 'jenkins::slave' do
  shared_context 'a jenkins::slave catalog' do
    it do
      should contain_archive('get_swarm_client').with(
        cleanup: false,
        extract: false,
      )
    end
    it { should contain_file(slave_service_file) }
    it { should contain_service('jenkins-slave').with(enable: true, ensure: 'running') }
    # Let the different platform blocks define  `slave_runtime_file` separately below
    it { should contain_file(slave_runtime_file).with_content(/^FSROOT="\/home\/jenkins-slave"$/) }
    it { should contain_file(slave_runtime_file).without_content(/ -name /) }
    it { should contain_file(slave_runtime_file).with_content(/^AUTO_DISCOVERY_ADDRESS=""$/) }

    describe 'with manage_slave_user true and manage_client_jar enabled' do
      let(:params) { { manage_slave_user: true, manage_client_jar: true } }
      it { should contain_user('jenkins-slave_user').with_uid(nil).that_comes_before('Archive[get_swarm_client]') }
    end

    describe 'with manage_slave_user true and manage_client_jar false' do
      let(:params) { { manage_slave_user: true, manage_client_jar: false } }
      it { should contain_user('jenkins-slave_user').with_uid(nil) }
    end

    describe 'with auto discovery address' do
      let(:params) { { autodiscoveryaddress: '255.255.255.0' } }
      it { should contain_file(slave_runtime_file).with_content(/^AUTO_DISCOVERY_ADDRESS="255.255.255.0"$/) }
    end

    describe 'slave_uid' do
      let(:params) { { slave_uid: 123 } }
      it { should contain_user('jenkins-slave_user').with_uid(123) }
    end

    describe 'slave_groups' do
      let(:params) { { slave_groups: 'docker' } }
      it { should contain_user('jenkins-slave_user').with_groups('docker') }
    end

    describe 'with a non-default $slave_home' do
      let(:home) { '/home/rspec-runner' }
      let(:params) { { slave_home: home } }
      it { should contain_file(slave_runtime_file).with_content(/^FSROOT="#{home}"$/) }
    end

    describe 'with service disabled' do
      let(:params) { { enable: false, ensure: 'stopped' } }
      it { should contain_service('jenkins-slave').with(enable: false, ensure: 'stopped') }
    end

    describe 'with tool_locations' do
      let(:params) { { tool_locations: 'Python-2.7:/usr/bin/python2.7 Java-1.8:/usr/bin/java' } }
      it do
        should contain_file(slave_runtime_file).
          with_content(/Python-2.7=\/usr\/bin\/python2.7/).
          with_content(/Java-1.8=\/usr\/bin\/java/)
      end
    end

    describe 'with a UI user/password' do
      let(:user) { '"frank"' }
      let(:password) { "abignale's" }
      let(:params) do
        {
          ui_user: user,
          ui_pass: password
        }
      end

      it 'escapes the user' do
        should contain_file(slave_runtime_file).with_content(/^JENKINS_USERNAME='#{user}'$/)
      end

      it 'escapes the password' do
        should contain_file(slave_runtime_file).with_content(/^JENKINS_PASSWORD="#{password}"$/)
      end
    end

    describe 'with java_args as a string' do
      let(:args) { '-Xmx2g' }
      let(:params) do
        {
          java_args: args
        }
      end

      it 'sets java_args' do
        should contain_file(slave_runtime_file).with_content(/^JAVA_ARGS="#{args}"$/)
      end
    end

    describe 'with java_args as an array' do
      let(:args) { ['-Xmx2g', '-Xms128m' ] }
      let(:params) do
        {
          java_args: args
        }
      end

      it 'converts java_args to a string' do
        args_as_string = args.join ' '
        should contain_file(slave_runtime_file).with_content(/^JAVA_ARGS="#{args_as_string}"$/)
      end
    end

    describe 'with swarm_client_args as a string' do
      let(:args) { '-disableSslVerification -disableClientsUniqueId' }
      let(:params) do
        {
          swarm_client_args: args
        }
      end

      it 'sets swarm_client_args' do
        should contain_file(slave_runtime_file).with_content(/^OTHER_ARGS="#{args}"$/)
      end
    end

    describe 'with swarm_client_args as an array' do
      let(:args) { ['-disableSslVerification', '-disableClientsUniqueId' ] }
      let(:params) do
        {
          swarm_client_args: args
        }
      end

      it 'converts swarm_client_args to a string' do
        args_as_string = args.join ' '
        should contain_file(slave_runtime_file).with_content(/^OTHER_ARGS="#{args_as_string}"$/)
      end
    end

    describe 'with tunnel specified' do
      context 'with invalid tunnel specified' do
        let(:params) do
          {
            tunnel: ':',
          }
        end
        it { should raise_error(Puppet::Error,/Error while evaluating a Resource Statement/) }
      end

      context 'as a valid tunnel' do
        context 'with HOST:PORT specified' do
          let(:params) do
            {
              tunnel: 'localhost:9000',
            }
          end

          it {should contain_file(slave_runtime_file).with_content(/^TUNNEL="localhost:9000"$/)}
        end

        context 'with HOST: specified' do
          let(:params) do
            {
              tunnel: 'localhost:',
            }
          end

          it {should contain_file(slave_runtime_file).with_content(/^TUNNEL="localhost:"$/)}
        end

        context 'with :PORT specified' do
          let(:params) do
            {
              tunnel: ':9000',
            }
          end

          it {should contain_file(slave_runtime_file).with_content(/^TUNNEL=":9000"$/)}
        end
      end
    end

    describe 'with different swarm versions' do
      let(:source) { 'http://rspec.example.com' }
      context 'a version lower than 3.0' do
        let(:params) do
          {
            version: '2.0',
            source: source
          }
        end
        it { should contain_archive('get_swarm_client').with_source("#{source}/swarm-client-2.0-jar-with-dependencies.jar") }
      end
      context 'a version higher than 3.0' do
        let(:params) do
          {
            version: '3.1',
            source: source
          }
        end
        it { should contain_archive('get_swarm_client').with_source("#{source}/swarm-client-3.1.jar") }
      end
    end

    describe 'with LABELS as an array' do
      let(:params) do
        {
          labels: ['hello', 'world']
        }
      end

      it 'sets LABEL as a string' do
        should contain_file(slave_runtime_file).with_content(/^LABELS="hello world"$/)
      end
    end

    describe 'with LABELS as a string' do
      let(:params) do
        {
          labels: ['unlimited blades']
        }
      end

      it 'sets LABEL as a string' do
        should contain_file(slave_runtime_file).with_content(/^LABELS="unlimited blades"$/)
      end
    end
    describe 'disable unique client id' do
      let(:params) do
        {
          disable_clients_unique_id: true
        }
      end
      it 'has disable variable' do
        should contain_file(slave_runtime_file)
          .with_content(/^DISABLE_CLIENTS_UNIQUE_ID="true"$/)
      end
    end

    describe 'delete_existing_clients' do
      context 'true' do
        let(:params) { { delete_existing_clients: true } }

        it do
          should contain_file(slave_runtime_file)
            .with_content(/^DELETE_EXISTING_CLIENTS="true"$/)
        end
      end

      context 'false' do
        let(:params) { { delete_existing_clients: false } }

        it do
          should contain_file(slave_runtime_file)
            .with_content(/^DELETE_EXISTING_CLIENTS=""$/)
        end
      end
    end # delete_existing_clients
  end

  shared_examples 'using slave_name' do
    it { should contain_file(slave_runtime_file).with_content(/^CLIENT_NAME="jenkins-slave"$/) }
  end

  describe 'RedHat' do
    context 'sysv init' do
      let(:facts) do
        {
          osfamily: 'RedHat',
          operatingsystem: 'CentOS',
          operatingsystemrelease: '6.7',
          operatingsystemmajrelease: '6',
          kernel: 'Linux',
          systemd: false
        }
      end
      let(:slave_runtime_file) { '/etc/sysconfig/jenkins-slave' }
      let(:slave_service_file) { '/etc/init.d/jenkins-slave' }
      let(:slave_startup_script) { '/home/jenkins-slave/jenkins-slave-run' }

      it_behaves_like 'a jenkins::slave catalog'

      it do
        should contain_file(slave_startup_script)
          .that_notifies('Service[jenkins-slave]')
      end

      describe 'with slave_name' do
        let(:params) { { slave_name: 'jenkins-slave' } }
        it_behaves_like 'using slave_name'
      end

      it { should_not contain_package('daemon') }

      context '::jenkins & ::jenkins::slave should co-exist' do
        let(:pre_condition) do
          <<-'EOS'
            include ::jenkins
            include ::jenkins::slave
          EOS
        end

        it { should_not raise_error }
      end

      describe 'with proxy_server' do
        let(:params) { { proxy_server: 'https://foo' } }
        it do
          should contain_archive('get_swarm_client').with(
            proxy_server: 'https://foo'
          )
        end
      end
    end # sysv init

    describe 'with systemd' do
      let(:facts) do
        {
          osfamily: 'RedHat',
          operatingsystem: 'CentOS',
          operatingsystemrelease: '7.2',
          operatingsystemmajrelease: '7',
          kernel: 'Linux',
          systemd: true
        }
      end
      let(:slave_runtime_file) { '/etc/sysconfig/jenkins-slave' }
      let(:slave_service_file) { '/etc/systemd/system/jenkins-slave.service' }
      let(:slave_startup_script) { '/home/jenkins-slave/jenkins-slave-run' }
      let(:slave_sysv_file) { '/etc/init.d/jenkins-slave' }

      it_behaves_like 'a jenkins::slave catalog'
      it do
        should contain_file(slave_startup_script)
          .that_notifies('Service[jenkins-slave]')
      end
      # XXX the prior_to args check fails under puppet 3.8.7 for unknown
      # reasons...
      if Puppet::Util::Package.versioncmp(Puppet.version, '4.0.0') >= 0
        it do
          should contain_transition('stop jenkins-slave service').with(
            prior_to: [ "File[#{slave_sysv_file}]" ],
          )
        end
      else
        it { should contain_transition('stop jenkins-slave service') }
      end
      it do
        should contain_file(slave_sysv_file)
          .with(
            ensure: 'absent',
            selinux_ignore_defaults: true,
          )
          .that_comes_before('Systemd::Unit_file[jenkins-slave.service]')
      end
      it do
        should contain_systemd__unit_file('jenkins-slave.service')
          .that_notifies('Service[jenkins-slave]')
      end
    end
  end

  describe 'Debian' do
    let(:facts) { { osfamily: 'Debian', lsbdistid: 'debian', lsbdistcodename: 'natty', operatingsystem: 'Debian', kernel: 'Linux' } }
    let(:slave_runtime_file) { '/etc/default/jenkins-slave' }
    let(:slave_service_file) { '/etc/init.d/jenkins-slave' }

    it_behaves_like 'a jenkins::slave catalog'

    describe 'with slave_name' do
      let(:params) { { slave_name: 'jenkins-slave' } }
      it_behaves_like 'using slave_name'
    end

    it do
      should contain_package('daemon')
        .that_comes_before('Service[jenkins-slave]')
    end
  end

  describe 'Darwin' do
    let(:facts) do
      { osfamily: 'Darwin',
        operatingsystem: 'Darwin',
        kernel: 'Darwin' }
    end
    let(:home) { '/home/jenkins-slave' }
    let(:slave_runtime_file) { "#{home}/jenkins-slave" }
    let(:slave_service_file) { '/Library/LaunchDaemons/org.jenkins-ci.slave.jnlp.plist' }

    it_behaves_like 'a jenkins::slave catalog'

    # NOTE: pending because jenkins-slave doesn't get installed on Darwin
    describe 'with slave_name' do
      let(:params) { { slave_name: 'jenkins-slave' } }
      it_behaves_like 'using slave_name'
    end

    it { should_not contain_package('daemon') }
  end

  describe 'Unknown' do
    let(:facts) { { ostype: 'Unknown' } }
    it { expect { should raise_error(Puppet::Error) } }
  end
end
