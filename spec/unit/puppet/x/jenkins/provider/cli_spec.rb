require 'spec_helper'
require 'unit/puppet/x/spec_jenkins_providers'

require 'puppet/x/jenkins/provider/cli'

describe Puppet::X::Jenkins::Provider::Cli do
  AuthError = Puppet::X::Jenkins::Provider::Cli::AuthError
  NetError = Puppet::X::Jenkins::Provider::Cli::NetError
  UnknownError = Puppet::X::Jenkins::Provider::Cli::UnknownError

  CLI_AUTH_ERRORS = [<<-EOS, <<-EOS, <<-EOS, <<-EOS].freeze
    anonymous is missing the Overall/Read permission
  EOS
    You must authenticate to access this Jenkins.
    Use --username/--password/--password-file parameters or login command.
  EOS
    anonymous is missing the Overall/RunScripts permission
  EOS
    anonymous is missing the Overall/Administer permission
  EOS

  CLI_NET_ERRORS = [<<-EOS, <<-EOS].freeze
    SEVERE: I/O error in channel CLI connection
  EOS
    java.net.SocketException: Connection reset
  EOS

  shared_context 'facts' do
    before do
      Facter.add(:jenkins_cli_jar) { setcode { 'fact.jar' } }
      Facter.add(:jenkins_url) { setcode { 'http://localhost:11' } }
      Facter.add(:jenkins_ssh_private_key) { setcode { 'fact.id_rsa' } }
      Facter.add(:jenkins_puppet_helper) { setcode { 'fact.groovy' } }
      Facter.add(:jenkins_cli_username) { setcode { 'myuser' } }
      Facter.add(:jenkins_cli_tries) { setcode { 22 } }
    end
  end

  before do
    Facter.clear
    # clear class level state
    if described_class.class_variable_defined?(:@@cli_auth_required)
      described_class.class_variable_set(:@@cli_auth_required, false)
    end
    allow(described_class).to receive(:command).with(:java).and_return('java')
  end

  describe '::suitable?' do
    it { expect(described_class.suitable?).to eq true }
  end

  include_examples 'confines to cli dependencies'

  describe '::sname' do
    it 'returns a short class name' do
      expect(described_class.sname).to eq 'Jenkins::Provider::Cli'
    end
  end

  describe '::instances' do
    it 'is not implemented' do
      expect { described_class.instances }.to raise_error(Puppet::DevError)
    end
  end

  describe '::prefetch' do
    let(:catalog) { Puppet::Resource::Catalog.new }

    it 'associates a provider with an instance' do
      resource = Puppet::Type.type(:notify).new(name: 'test')
      catalog.add_resource resource

      provider = described_class.new(name: 'test')

      expect(described_class).to receive(:instances).
        with(catalog) { [provider] }

      described_class.prefetch(resource.name => resource)

      expect(resource.provider).to eq provider
    end

    it 'does not break an existing resource/provider association' do
      resource = Puppet::Type.type(:notify).new(name: 'test')
      catalog.add_resource resource

      provider = described_class.new(name: 'test')
      resource.provider = provider

      expect(described_class).to receive(:instances).
        with(catalog) { [provider] }

      described_class.prefetch(resource.name => resource)

      expect(resource.provider).to eq provider
    end
  end # ::prefetch

  describe '#create' do
    context ':ensure' do
      it do
        provider = described_class.new

        expect(provider.instance_variable_get(:@property_hash)[:ensure]).to eq nil
        provider.create
        expect(provider.instance_variable_get(:@property_hash)[:ensure]).to eq :present
      end
    end
  end # #create

  describe '#exists?' do
    context 'when :ensure is unset' do
      it do
        provider = described_class.new
        expect(provider.exists?).to eq false
      end
    end

    context 'when :ensure is :absent' do
      it 'returns true' do
        provider = described_class.new(ensure: :absent)
        expect(provider.exists?).to eq false
      end
    end

    context 'when :ensure is :present' do
      it 'returns true' do
        provider = described_class.new(ensure: :present)
        expect(provider.exists?).to eq true
      end
    end
  end # #exists?'

  describe '#destroy' do
    context ':ensure' do
      it do
        provider = described_class.new

        expect(provider.instance_variable_get(:@property_hash)[:ensure]).to eq nil
        provider.destroy
        expect(provider.instance_variable_get(:@property_hash)[:ensure]).to eq :absent
      end
    end
  end # #destroy

  describe '#flush' do
    it 'clears @property_hash' do
      provider = described_class.new
      provider.create
      provider.flush

      expect(provider.instance_variable_get(:@property_hash)).to eq({})
    end
  end # #flush

  describe '#cli' do
    let(:provider) { described_class.new }

    it 'is an instance method' do
      expect(provider).to respond_to(:cli)
    end

    it 'has the same method signature as ::cli' do
      expect(described_class.new).to respond_to(:cli).with(2).arguments
    end

    it 'wraps ::cli class method' do
      expect(described_class).to receive(:cli).with('foo', {})
      provider.cli('foo', {})
    end

    it 'extracts the catalog from the resource' do
      resource = Puppet::Type.type(:notify).new(name: 'test')
      catalog = Puppet::Resource::Catalog.new
      resource.provider = provider
      catalog.add_resource resource

      expect(described_class).to receive(:cli).with(
        'foo', catalog: catalog
      )

      provider.cli('foo', {})
    end
  end # #cli

  describe '#clihelper' do
    let(:provider) { described_class.new }

    it 'is an instance method' do
      expect(provider).to respond_to(:clihelper)
    end

    it 'has the same method signature as ::clihelper' do
      expect(described_class.new).to respond_to(:clihelper).with(2).arguments
    end

    it 'wraps ::clihelper class method' do
      expect(described_class).to receive(:clihelper).with('foo', {})
      provider.clihelper('foo', {})
    end

    it 'extracts the catalog from the resource' do
      resource = Puppet::Type.type(:notify).new(name: 'test')
      catalog = Puppet::Resource::Catalog.new
      resource.provider = provider
      catalog.add_resource resource

      expect(described_class).to receive(:clihelper).with(
        'foo', catalog: catalog
      )

      provider.clihelper('foo', {})
    end
  end # #clihelper

  describe '::clihelper' do
    shared_examples 'uses default values' do
      it 'uses default values' do
        expect(described_class).to receive(:cli).with(
          ['groovy', '=', 'foo'],
          { tmpfile_as_param: true },
          ['/bin/cat', '/usr/lib/jenkins/puppet_helper.groovy', '|']
        )

        described_class.clihelper('foo')
      end
    end # uses default values

    shared_examples 'uses fact values' do
      it 'uses fact values' do
        expect(described_class).to receive(:cli).with(
          ['groovy', '=', 'foo'],
          { tmpfile_as_param: true },
          ['/bin/cat', 'fact.groovy', '|']
        )

        described_class.clihelper('foo')
      end
    end # uses fact values

    shared_examples 'uses catalog values' do
      it 'uses catalog values' do
        expect(described_class).to receive(:cli).with(
          ['groovy', '=', 'foo'],
          { catalog: catalog, tmpfile_as_param: true },
          ['/bin/cat', 'cat.groovy', '|']
        )

        described_class.clihelper('foo', catalog: catalog)
      end
    end # uses catalog values

    it 'is a class method' do
      expect(described_class).to respond_to(:clihelper)
    end

    it 'wraps ::cli class method' do
      expect(described_class).to receive(:cli)
      described_class.clihelper('foo')
    end

    context 'no catalog' do
      context 'no facts' do
        include_examples 'uses default values'
      end # no facts

      context 'with facts' do
        include_context 'facts'

        include_examples 'uses fact values'
      end # with facts
    end # no catalog

    context 'with catalog' do
      let(:catalog) { Puppet::Resource::Catalog.new }

      context 'no jenkins::cli::config class' do
        context 'no facts' do
          include_examples 'uses default values'
        end # no facts

        context 'with facts' do
          include_context 'facts'

          include_examples 'uses fact values'
        end # with facts
      end # no jenkins::cli::config class

      context 'with jenkins::cli::config class' do
        before do
          jenkins = Puppet::Type.type(:component).new(
            name: 'jenkins::cli::config',
            puppet_helper: 'cat.groovy'
          )

          catalog.add_resource jenkins
        end

        context 'no facts' do
          include_examples 'uses catalog values'
        end # no facts

        context 'with facts' do
          include_context 'facts'

          include_examples 'uses catalog values'
        end # with facts
      end # with jenkins::cli::config class
    end # with catalog
  end # ::clihelper

  describe '::cli' do
    shared_examples 'uses default values' do
      it 'uses default values' do
        expect(described_class.superclass).to receive(:execute).with(
          'java -jar /usr/lib/jenkins/jenkins-cli.jar -s http://localhost:8080 -logger WARNING foo',
          failonfail: true, combine: true
        )

        described_class.cli('foo')
      end
    end # uses default values

    shared_examples 'uses fact values' do
      it 'uses fact values' do
        expect(described_class.superclass).to receive(:execute).with(
          'java -jar fact.jar -s http://localhost:11 -logger WARNING foo',
          failonfail: true, combine: true
        )

        described_class.cli('foo')
      end
    end # uses fact values

    shared_examples 'uses catalog values' do
      it 'uses catalog values' do
        expect(described_class.superclass).to receive(:execute).with(
          'java -jar cat.jar -s http://localhost:111 -logger WARNING foo',
          failonfail: true, combine: true
        )

        described_class.cli('foo', catalog: catalog)
      end
    end # uses catalog values

    it 'is a class method' do
      expect(described_class).to respond_to(:cli)
    end

    it 'wraps the superclasses ::execute method' do
      expect(described_class.superclass).to receive(:execute)
      described_class.cli('foo')
    end

    context 'no catalog' do
      context 'no facts' do
        include_examples 'uses default values'
      end # no facts

      context 'with facts' do
        include_context 'facts'

        include_examples 'uses fact values'
      end # with facts
    end # no catalog

    context 'with catalog' do
      let(:catalog) { Puppet::Resource::Catalog.new }

      context 'no jenkins::cli::config class' do
        context 'no facts' do
          include_examples 'uses default values'
        end # no facts

        context 'with facts' do
          include_context 'facts'

          include_examples 'uses fact values'
        end # with facts
      end # no jenkins::cli::config class

      context 'with jenkins::cli::config class' do
        before do
          jenkins = Puppet::Type.type(:component).new(
            name: 'jenkins::cli::config',
            cli_jar: 'cat.jar',
            url: 'http://localhost:111',
            ssh_private_key: 'cat.id_rsa',
            cli_username: 'myuser',
            cli_tries: 222
          )

          catalog.add_resource jenkins
        end

        context 'no facts' do
          include_examples 'uses catalog values'
        end # no facts

        context 'with facts' do
          include_context 'facts'

          include_examples 'uses catalog values'
        end # with facts
      end # with jenkins::cli::config class
    end # with catalog

    context 'auth failure' do
      context 'without ssh_private_key' do
        CLI_AUTH_ERRORS.each do |error|
          it 'does not retry cli on AuthError exception' do
            expect(described_class).to receive(:execute_with_auth).once.and_raise(AuthError, error)
            expect(Puppet::Util::RetryAction).not_to receive(:sleep)

            expect { described_class.cli('foo') }.
              to raise_error(AuthError)
          end
        end
      end
      # without ssh_private_key

      context 'with ssh_private_key' do
        let(:catalog) { Puppet::Resource::Catalog.new }

        before do
          jenkins = Puppet::Type.type(:component).new(
            name: 'jenkins::cli::config',
            cli_username: 'myuser',
            ssh_private_key: 'cat.id_rsa'
          )
          catalog.add_resource jenkins
        end

        it 'tries cli without auth first' do
          expect(described_class.superclass).to receive(:execute).with(
            'java -jar /usr/lib/jenkins/jenkins-cli.jar -s http://localhost:8080 -logger WARNING foo',
            failonfail: true, combine: true
          )

          described_class.cli('foo', catalog: catalog)
        end

        CLI_AUTH_ERRORS.each do |error|
          it 'retries cli on AuthError exception' do
            expect(described_class.superclass).to receive(:execute).with(
              'java -jar /usr/lib/jenkins/jenkins-cli.jar -s http://localhost:8080 -logger WARNING foo',
              failonfail: true, combine: true
            ).and_raise(AuthError, error)

            expect(described_class.superclass).to receive(:execute).with(
              'java -jar /usr/lib/jenkins/jenkins-cli.jar -s http://localhost:8080 -logger WARNING -i cat.id_rsa -ssh -user myuser foo',
              failonfail: true, combine: true
            )

            described_class.cli('foo', catalog: catalog)

            # and it should remember that auth is required
            expect(described_class.superclass).not_to receive(:execute).with(
              'java -jar /usr/lib/jenkins/jenkins-cli.jar -s http://localhost:8080 -logger WARNING foo',
              failonfail: true, combine: true
            )

            expect(described_class.superclass).to receive(:execute).with(
              'java -jar /usr/lib/jenkins/jenkins-cli.jar -s http://localhost:8080 -logger WARNING -i cat.id_rsa -ssh -user myuser foo',
              failonfail: true, combine: true
            )

            described_class.cli('foo', catalog: catalog)
          end
        end
      end # with ssh_private_key
    end # auth failure

    context 'network failure' do
      context 'without ssh_private_key' do
        CLI_NET_ERRORS.each do |error|
          it 'retries cli on NetError exception' do
            expect(described_class).to receive(:execute_with_auth).exactly(31).times.and_raise(NetError, error)
            expect(Puppet::Util::RetryAction).to receive(:sleep).exactly(30).times

            expect { described_class.cli('foo') }.
              to raise_error(Puppet::Util::RetryAction::RetryException::RetriesExceeded)
          end
        end
      end
      # without ssh_private_key
    end # network failure

    context 'when UnknownError exception' do
      let(:catalog) { Puppet::Resource::Catalog.new }

      context 'retry n times' do
        it 'by default' do
          jenkins = Puppet::Type.type(:component).new(
            name: 'jenkins::cli::config'
          )
          catalog.add_resource jenkins

          expect(Puppet::Util::RetryAction).to receive(:retry_action).with(retries: 30, retry_exceptions: [UnknownError, NetError]).and_raise(UnknownError, 'foo')

          expect { described_class.cli('foo', catalog: catalog) }.
            to raise_error(UnknownError, 'foo')
        end

        it 'from catalog value' do
          jenkins = Puppet::Type.type(:component).new(
            name: 'jenkins::cli::config',
            cli_tries: 2
          )
          catalog.add_resource jenkins

          expect(Puppet::Util::RetryAction).to receive(:retry_action).with(retries: 2, retry_exceptions: [UnknownError, NetError]).and_raise(UnknownError, 'foo')

          expect { described_class.cli('foo', catalog: catalog) }.
            to raise_error(UnknownError, 'foo')
        end

        it 'from fact' do
          Facter.add(:jenkins_cli_tries) { setcode { 3 } }

          jenkins = Puppet::Type.type(:component).new(
            name: 'jenkins::cli::config'
          )
          catalog.add_resource jenkins

          expect(Puppet::Util::RetryAction).to receive(:retry_action).with(retries: 3, retry_exceptions: [UnknownError, NetError]).and_raise(UnknownError, 'foo')

          expect { described_class.cli('foo', catalog: catalog) }.
            to raise_error(UnknownError, 'foo')
        end

        it 'from catalog overriding fact' do
          Facter.add(:jenkins_cli_tries) { setcode { 3 } }

          jenkins = Puppet::Type.type(:component).new(
            name: 'jenkins::cli::config',
            cli_tries: 2
          )
          catalog.add_resource jenkins

          expect(Puppet::Util::RetryAction).to receive(:retry_action).with(retries: 2, retry_exceptions: [UnknownError, NetError]).and_raise(UnknownError, 'foo')

          expect { described_class.cli('foo', catalog: catalog) }.
            to raise_error(UnknownError, 'foo')
        end
      end # n times
    end # should retry cli on UnknownError

    context 'options with :stdinjson' do
      RSpec::Matchers.define :a_json_doc do |x|
        match { |actual| JSON.parse(actual) == x }
      end

      let(:realm_oauth_json) do
        <<-EOS
          {
              "setSecurityRealm": {
                  "org.jenkinsci.plugins.GithubSecurityRealm": [
                      "https://github.com",
                      "https://api.github.com",
                      "42",
                      "43",
                      "read:org"
                  ]
              }
          }
        EOS
      end
      let(:realm_oauth) { JSON.parse(realm_oauth_json) }

      it 'generates a temp file with json output' do
        tmp = instance_double('Template')

        expect(Tempfile).to receive(:open) { tmp }
        expect(tmp).to receive(:write).with(a_json_doc(realm_oauth))
        expect(tmp).to receive(:flush)
        expect(tmp).to receive(:close)
        expect(tmp).to receive(:unlink)
        expect(tmp).to receive(:path) { '/dne.tmp' }

        expect(described_class.superclass).to receive(:execute).with(
          'java -jar /usr/lib/jenkins/jenkins-cli.jar -s http://localhost:8080 -logger WARNING foo',
          failonfail: true,
          combine: true,
          stdinfile: '/dne.tmp'
        )

        described_class.cli('foo', stdinjson: realm_oauth)
      end
    end # options with :stdinjson

    context 'options with :stdin' do
      it 'generates a temp file with stdin string' do
        tmp = instance_double('Template')

        expect(Tempfile).to receive(:open) { tmp }
        expect(tmp).to receive(:write).with('bar')
        expect(tmp).to receive(:flush)
        expect(tmp).to receive(:close)
        expect(tmp).to receive(:unlink)
        expect(tmp).to receive(:path) { '/dne.tmp' }

        expect(described_class.superclass).to receive(:execute).with(
          'java -jar /usr/lib/jenkins/jenkins-cli.jar -s http://localhost:8080 -logger WARNING foo',
          failonfail: true,
          combine: true,
          stdinfile: '/dne.tmp'
        )

        described_class.cli('foo', stdin: 'bar')
      end
    end # options with :stdin
  end # ::cli
end
