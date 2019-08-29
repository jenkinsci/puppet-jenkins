require 'spec_helper'

describe 'jenkins::plugin' do
  let(:title) { 'myplug' }
  let(:facts) do
    {
      osfamily: 'RedHat',
      operatingsystem: 'CentOS',
      operatingsystemrelease: '6.7',
      operatingsystemmajrelease: '6'
    }
  end
  let(:pdir) { '/var/lib/jenkins/plugins' }
  let(:plugin_host) { 'https://updates.jenkins.io' }

  describe 'without version' do
    it do
      is_expected.to contain_archive("#{title}.jpi").with(
        source: "#{plugin_host}/latest/myplug.hpi",
        path: "#{pdir}/#{title}.jpi",
        cleanup: false,
        extract: false
      ).that_requires("File[#{pdir}]").
        that_notifies('Service[jenkins]')
    end
    it do
      is_expected.to contain_file("#{pdir}/#{title}.jpi").with(
        owner: 'jenkins',
        group: 'jenkins',
        mode: '0644'
      ).that_comes_before('Service[jenkins]')
    end
  end

  describe 'with version' do
    let(:params) { { version: '1.2.3' } }

    it do
      is_expected.to contain_archive('myplug.jpi').with(
        source: "#{plugin_host}/download/plugins/myplug/1.2.3/myplug.hpi"
      )
    end
    it { is_expected.to contain_file("#{pdir}/myplug.jpi") }
  end

  describe 'with version and in middle of jenkins_plugins fact' do
    let(:params) { { version: '1.2.3' } }

    before { facts[:jenkins_plugins] = 'myplug 1.2.3, fooplug 1.4.5' }

    it { is_expected.not_to contain_archive('myplug.jpi') }
    it { is_expected.to contain_file("#{pdir}/myplug.jpi") }
  end

  describe 'with version and at end of jenkins_plugins fact' do
    let(:params) { { version: '1.2.3' } }

    before { facts[:jenkins_plugins] = 'fooplug 1.4.5, myplug 1.2.3' }

    it { is_expected.not_to contain_archive('myplug.jpi') }
    it { is_expected.to contain_file("#{pdir}/myplug.jpi") }
  end

  describe 'with name and version' do
    describe 'where name & version are a substring of another plugin' do
      let(:params) { { version: '1.2.3' } }

      before { facts[:jenkins_plugins] = 'fooplug 1.4.5, bar-myplug 1.2.3' }

      it { is_expected.to contain_archive('myplug.jpi') }
      it { is_expected.to contain_file('/var/lib/jenkins/plugins/myplug.jpi') }
    end

    describe 'where name & version are a substring of another plugin' do
      let(:params) { { version: '1.2.3' } }

      before { facts[:jenkins_plugins] = 'fooplug 1.4.5, bar-myplug 1.2.3.4' }

      it { is_expected.to contain_archive('myplug.jpi') }
      it { is_expected.to contain_file('/var/lib/jenkins/plugins/myplug.jpi') }
    end

    describe 'where version is a substring of the already installed plugin' do
      let(:params) { { version: '1.2.3' } }

      before { facts[:jenkins_plugins] = 'fooplug 1.4.5, myplug 1.2.3.4' }

      it { is_expected.to contain_archive('myplug.jpi') }
      it { is_expected.to contain_file('/var/lib/jenkins/plugins/myplug.jpi') }
    end

    describe 'and no plugins are installed (should not actually happen)' do
      let(:params) { { version: '1.2.3' } }

      before { facts[:jenkins_plugins] = '' }

      it { is_expected.to contain_archive('myplug.jpi') }
      it { is_expected.to contain_file('/var/lib/jenkins/plugins/myplug.jpi') }
    end

    describe 'where version contains a + and is already installed' do
      let(:params) { { version: '1.2+3.4' } }

      before { facts[:jenkins_plugins] = 'myplug 1.2+3.4' }

      it { is_expected.not_to contain_archive('myplug.jpi') }
      it { is_expected.to contain_file('/var/lib/jenkins/plugins/myplug.jpi') }
    end
  end # 'with name and version'

  describe 'with enabled is false' do
    let(:params) { { enabled: false } }

    it { is_expected.to contain_archive('myplug.jpi') }
    it { is_expected.to contain_file("#{pdir}/myplug.jpi") }
    it do
      is_expected.to contain_file("#{pdir}/myplug.jpi.disabled").with(
        ensure: 'present',
        owner: 'jenkins',
        group: 'jenkins',
        mode: '0644'
      ).that_requires("Archive[#{title}.jpi]").
        that_notifies('Service[jenkins]')
    end
  end

  describe 'with enabled is true' do
    let(:params) { { enabled: true } }

    it { is_expected.to contain_archive('myplug.jpi') }
    it { is_expected.to contain_file("#{pdir}/myplug.jpi") }
    it do
      is_expected.to contain_file("#{pdir}/myplug.jpi.disabled").with(
        ensure: 'absent'
      )
    end
  end

  describe 'with proxy' do
    let(:pre_condition) do
      <<-EOS
        class { jenkins:
          proxy_host => "proxy.company.com",
          proxy_port => 8080,
        }
      EOS
    end

    it do
      is_expected.to contain_archive('myplug.jpi').with(
        proxy_server: 'http://proxy.company.com:8080'
      )
    end
  end

  describe 'with custom default_plugins_host' do
    let(:pre_condition) do
      <<-EOS
        class { jenkins:
          default_plugins_host => "https://update.jenkins.custom",
        }
      EOS
    end

    it do
      is_expected.to contain_archive('myplug.jpi').with(
        source: 'https://update.jenkins.custom/latest/myplug.hpi'
      )
    end
  end

  describe 'with a custom update center' do
    shared_examples 'execute the right fetch command' do
      it 'retrieves the plugin' do
        expect(subject).to contain_archive('git.jpi').with(source: expected_url.to_s)
      end
    end

    let(:title) { 'git' }

    context 'by default' do
      context 'with a version' do
        let(:version) { '1.3.3.7' }
        let(:params) { { version: version } }
        let(:expected_url) do
          "#{plugin_host}/download/plugins/#{title}/#{version}/#{title}.hpi"
        end

        include_examples 'execute the right fetch command'
      end

      context 'without a version' do
        let(:expected_url) do
          "#{plugin_host}/latest/#{title}.hpi"
        end

        include_examples 'execute the right fetch command'
      end
    end

    context 'with a custom update_url' do
      let(:update_url) { 'http://rspec' }

      context 'without a version' do
        let(:params) { { update_url: update_url } }
        let(:expected_url) do
          "#{update_url}/latest/#{title}.hpi"
        end

        include_examples 'execute the right fetch command'
      end

      context 'with a version' do
        let(:version) { '1.2.3' }
        let(:params) { { update_url: update_url, version: version } }
        let(:expected_url) do
          "#{update_url}/download/plugins/#{title}/#{version}/#{title}.hpi"
        end

        include_examples 'execute the right fetch command'
      end
    end
  end

  describe 'source' do
    shared_examples 'should download from $source url' do
      it 'downloads from $source url' do
        is_expected.to contain_archive('myplug.jpi').with(
          source: 'http://e.org/myplug.hpi'
        ).
          that_requires("File[#{pdir}]")
      end
    end

    let(:params) { { source: 'http://e.org/myplug.hpi' } }

    context 'other params at defaults' do
      include_examples 'should download from $source url'
    end

    context '$update_url is set' do
      before { params[:update_url] = 'http://dne.org/' }

      include_examples 'should download from $source url'

      context 'and $version is set' do
        before { params[:version] = '42' }

        include_examples 'should download from $source url'
      end
    end

    context 'validate_string' do
      context 'string' do
        let(:params) { { source: 'foo.hpi' } }

        it { is_expected.not_to raise_error }
      end
    end # validate_string
  end # source

  context 'pinned file' do
    let(:title) { 'foo' }

    context 'with source param' do
      let(:params) { { source: 'foo.jpi' } }

      it { is_expected.to contain_file("#{pdir}/foo.jpi.pinned").without_ensure }
    end

    describe 'pin parameter' do
      context 'with pin => true' do
        let(:params) { { pin: true } }

        it do
          is_expected.to contain_file("#{pdir}/foo.jpi.pinned").with(
            ensure: 'file',
            owner: 'jenkins',
            group: 'jenkins'
          ).
            that_requires('Archive[foo.jpi]').
            that_notifies('Service[jenkins]')
        end
      end
      context 'with pin => false' do
        let(:params) { { pin: false } }

        it { is_expected.to contain_file("#{pdir}/foo.jpi.pinned").without_ensure }
      end
      context 'with default pin param' do
        it { is_expected.to contain_file("#{pdir}/foo.jpi.pinned").without_ensure }
      end
    end
  end # pinned file extension name

  describe 'purge plugins' do
    context 'true' do
      let(:pre_condition) do
        <<-EOS
          class { jenkins:
            purge_plugins => true,
          }
        EOS
      end

      it { is_expected.to contain_file("#{pdir}/#{title}") }
    end

    context 'false' do
      let(:pre_condition) do
        <<-EOS
          class { jenkins:
            purge_plugins => false,
          }
        EOS
      end

      it { is_expected.not_to contain_file("#{pdir}/#{title}") }
    end
  end # purge plugins

  describe 'deprecated params' do
    %w[
      plugin_dir
      username
      group
      create_user
    ].each do |param|
      context param do
        pending('rspec-puppet support for testing warning()')
      end
    end
  end # deprecated params
end
