require 'spec_helper'

describe 'jenkins::plugin' do
  let(:title) { 'myplug' }

  shared_examples 'manages plugins dirs' do
    it { should contain_file('/var/lib/jenkins') }
    it { should contain_file('/var/lib/jenkins/plugins') }
  end

  include_examples 'manages plugins dirs'
  it { should contain_group('jenkins') }
  it { should contain_user('jenkins').with('home' => '/var/lib/jenkins') }

  context 'with my plugin parent directory already defined' do
    let(:pre_condition) do
      [
        "file { '/var/lib/jenkins' : ensure => directory, }",
      ]
    end

    include_examples 'manages plugins dirs'
  end


  describe 'without version' do
    it do
      should contain_exec('download-myplug').with(
        :command     => 'rm -rf myplug myplug.hpi myplug.jpi && wget --no-check-certificate http://updates.jenkins-ci.org/latest/myplug.hpi',
        :user        => 'jenkins',
        :environment => nil
      )
    end
    it { should contain_file('/var/lib/jenkins/plugins/myplug.hpi')}
  end

  describe 'with version' do
    let(:params) { { :version => '1.2.3' } }

    it do
      should contain_exec('download-myplug').with(
        :command     => 'rm -rf myplug myplug.hpi myplug.jpi && wget --no-check-certificate http://updates.jenkins-ci.org/download/plugins/myplug/1.2.3/myplug.hpi',
        :user        => 'jenkins',
        :environment => nil
      )
    end
    it { should contain_file('/var/lib/jenkins/plugins/myplug.hpi')}
  end

  describe 'with version and in middle of jenkins_plugins fact' do
    let(:params) { { :version => '1.2.3' } }
    let(:facts) { { :jenkins_plugins => 'myplug 1.2.3, fooplug 1.4.5' } }

    it { should_not contain_exec('download-myplug') }
    it { should_not contain_file('/var/lib/jenkins/plugins/myplug.hpi')}
  end

  describe 'with version and at end of jenkins_plugins fact' do
    let(:params) { { :version => '1.2.3' } }
    let(:facts) { { :jenkins_plugins => 'fooplug 1.4.5, myplug 1.2.3' } }

    it { should_not contain_exec('download-myplug') }
    it { should_not contain_file('/var/lib/jenkins/plugins/myplug.hpi')}
  end

  describe 'with enabled is false' do
    let(:params) { { :enabled => false } }

    it { should contain_exec('download-myplug') }
    it { should contain_file('/var/lib/jenkins/plugins/myplug.hpi')}
    it { should contain_file('/var/lib/jenkins/plugins/myplug.hpi.disabled').with({
      :ensure => 'present',
      :owner  => 'jenkins',
    })}
    it { should contain_file('/var/lib/jenkins/plugins/myplug.jpi.disabled').with({
      :ensure => 'present',
      :owner  => 'jenkins',
    })}
  end

  describe 'with enabled is true' do
    let(:params) { { :enabled => true } }

    it { should contain_exec('download-myplug') }
    it { should contain_file('/var/lib/jenkins/plugins/myplug.hpi')}
    it { should contain_file('/var/lib/jenkins/plugins/myplug.hpi.disabled').with({
      :ensure => 'absent',
      :owner  => 'jenkins',
    })}
    it { should contain_file('/var/lib/jenkins/plugins/myplug.jpi.disabled').with({
      :ensure => 'absent',
      :owner  => 'jenkins',
    })}
  end

  describe 'with proxy' do
    let(:pre_condition) { [
      'class jenkins {
        $proxy_host = "proxy.company.com"
        $proxy_port = 8080
      }',
      'include jenkins'
    ]}

    it do
      should contain_exec('create-pinnedfile-myplug').with(
        :environment => [
          "http_proxy=proxy.company.com:8080",
          "https_proxy=proxy.company.com:8080",
          "no_proxy="
        ]
      )
      should contain_exec('download-myplug').with(
        :environment => [
          "http_proxy=proxy.company.com:8080",
          "https_proxy=proxy.company.com:8080",
          "no_proxy="
        ]
      )
    end
  end
  
  describe 'with proxy and no proxy' do
    let(:pre_condition) { [
      'class jenkins {
        $proxy_host = "proxy.company.com"
        $proxy_port = 8080
        $no_proxy_list = ["noproxy.company.com", "also-noproxy.com"]
      }',
      'include jenkins'
    ]}
    it do
      should contain_exec('create-pinnedfile-myplug').with(
        :environment => [
          "http_proxy=proxy.company.com:8080",
          "https_proxy=proxy.company.com:8080",
          "no_proxy=noproxy.company.com,also-noproxy.com"
        ]
      )
      should contain_exec('download-myplug').with(
        :environment => [
          "http_proxy=proxy.company.com:8080",
          "https_proxy=proxy.company.com:8080",
          "no_proxy=noproxy.company.com,also-noproxy.com"
        ]
      )
    end
  end

  describe 'with a custom update center' do
    shared_examples 'execute the right fetch command' do
      it 'should wget the plugin' do
        expect(subject).to contain_exec('download-git').with({
          :command => "rm -rf git git.hpi git.jpi && wget --no-check-certificate #{expected_url}",
        })
      end
    end

    let(:title) { 'git' }

    context 'by default' do
      context 'with a version' do
        let(:version) { '1.3.3.7' }
        let(:params) { {:version => version} }
        let(:expected_url) do
          "http://updates.jenkins-ci.org/download/plugins/#{title}/#{version}/#{title}.hpi"
        end

        include_examples 'execute the right fetch command'
      end

      context 'without a version' do
        let(:expected_url) do
          "http://updates.jenkins-ci.org/latest/#{title}.hpi"
        end

        include_examples 'execute the right fetch command'
      end
    end

    context 'with a custom update_url' do
      let(:update_url) { 'http://rspec' }

      context 'without a version' do
        let(:params) { {:update_url => update_url} }
        let(:expected_url) do
          "#{update_url}/latest/#{title}.hpi"
        end

        include_examples 'execute the right fetch command'
      end

      context 'with a version' do
        let(:version) { '1.2.3' }
        let(:params) { {:update_url => update_url, :version => version} }
        let(:expected_url) do
          "#{update_url}/download/plugins/#{title}/#{version}/#{title}.hpi"
        end

        include_examples 'execute the right fetch command'
      end
    end
  end
  context 'when not installing users' do
    let :params do
      {'create_user' => false}
    end
    it 'should not create user or group' do
      should_not contain_group('jenkins')
      should_not contain_user('jenkins')
    end
  end

  describe 'source' do
    shared_examples 'should download from $source url' do
      it 'should download from $source url' do
         should contain_exec('download-myplug').with(
          :command     => 'rm -rf myplug myplug.hpi myplug.jpi && wget --no-check-certificate http://e.org/myplug.hpi',
          :user        => 'jenkins',
          :cwd         => '/var/lib/jenkins/plugins',
          :environment => nil,
          :path        => ['/usr/bin', '/usr/sbin', '/bin'],
        )
        .that_requires('File[/var/lib/jenkins/plugins]')
        .that_requires('Package[wget]')
      end
    end

    let(:params) {{ :source => 'http://e.org/myplug.hpi' }}

    context 'other params at defaults' do
      include_examples 'should download from $source url'
    end

    context '$update_url is set' do
      before { params[:update_url] = 'http://dne.org/' }

      include_examples 'should download from $source url'

      context 'and $version is set' do
        before { params[:version] = 42 }

        include_examples 'should download from $source url'
      end
    end

    context 'validate_string' do
      context 'string' do
        let(:params) {{ :source => 'foo' }}

        it { should_not raise_error }
      end

      context 'array' do
        let(:params) {{ :source => [] }}

        it 'should fail' do
          should raise_error(Puppet::Error, /is not a string/)
        end
      end
    end # validate_string
  end # source
end
