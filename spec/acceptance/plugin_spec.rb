require 'spec_helper_acceptance'

describe 'jenkins class', order: :defined do
  $pdir = '/var/lib/jenkins/plugins'
  let(:pdir) { $pdir }

  # files/directories to test plugin purging removal of unmanaged files
  $files = [
    "#{$pdir}/a.hpi",
    "#{$pdir}/b.jpi",
    "#{$pdir}/c.txt",
    "#{$pdir}/a/foo",
    "#{$pdir}/b/bar",
    "#{$pdir}/c/baz"
  ]
  $dirs = [
    "#{$pdir}/a",
    "#{$pdir}/b",
    "#{$pdir}/c"
  ]

  shared_examples 'has_git_plugin' do
    describe file("#{$pdir}/git.jpi") do
      it { is_expected.to be_file }
    end
    describe file("#{$pdir}/git") do
      it { is_expected.to be_directory }
    end
  end

  shared_context 'plugin_test_files' do
    before(:context) do
      shell("mkdir -p #{$dirs.join(' ')}")
      shell("touch #{$files.join(' ')}")
    end
    after(:context) do
      shell("rm -rf #{$dirs.join(' ')} #{$files.join(' ')}")
    end
  end

  context 'default parameters' do
    pp = <<-EOS
    class {'jenkins':
      cli_remoting_free => true,
    }

    jenkins::plugin {'git-plugin':
      name    => 'git',
      version => '2.3.4',
    }
    EOS

    apply2(pp)

    it_behaves_like 'has_git_plugin'
  end

  describe 'plugin downgrade' do
    before(:all) do
      pp = <<-EOS
      class {'jenkins':
        cli_remoting_free => true,
        purge_plugins     => true,
      }

      jenkins::plugin {'git-plugin':
        name    => 'git',
        version => '2.3.4',
      }
      EOS

      apply(pp, catch_failures: true)
      apply(pp, catch_changes: true)
    end

    context 'downgrade' do
      git_version =
        it 'downgrades git version' do
          pp = <<-EOS
          package{'unzip':
            ensure => present
          }
          class {'jenkins':
            cli_remoting_free => true,
            purge_plugins     => true,
          }

          jenkins::plugin {'git-plugin':
            name    => 'git',
            version => '1.0',
          }
          EOS

          apply(pp, catch_failures: true)
          apply(pp, catch_changes: true)

          # Find the version of the installed git plugin
          git_version = shell("unzip -p #{$pdir}/git.jpi META-INF/MANIFEST.MF | sed 's/Plugin-Version: \\\(.*\\\)/\\1/;tx;d;:x'").stdout.strip
          git_version.should eq('1.0')
        end
      it_behaves_like 'has_git_plugin'
    end
  end

  describe 'plugin purging' do
    context 'true' do
      include_context 'plugin_test_files'

      it 'works with no errors' do
        pp = <<-EOS
        class {'jenkins':
          cli_remoting_free => true,
          purge_plugins     => true,
        }

        jenkins::plugin {'git-plugin':
          name    => 'git',
          version => '2.3.4',
        }
        EOS

        apply(pp, catch_failures: true)
        apply(pp, catch_changes: true)
      end

      it_behaves_like 'has_git_plugin'

      ($dirs + $files).each do |f|
        describe file(f) do
          it { is_expected.not_to exist }
        end
      end
    end # true

    context 'false' do
      include_context 'plugin_test_files'

      it 'works with no errors' do
        pp = <<-EOS
        class {'jenkins':
          cli_remoting_free => true,
          purge_plugins     => false,
        }

        jenkins::plugin {'git-plugin':
          name    => 'git',
          version => '2.3.4',
        }
        EOS

        apply(pp, catch_failures: true)
        apply(pp, catch_changes: true)
      end

      it_behaves_like 'has_git_plugin'

      $dirs.each do |f|
        describe file(f) do
          it { is_expected.to be_directory }
        end
      end

      $files.each do |f|
        describe file(f) do
          it { is_expected.to be_file }
        end
      end
    end # false
  end # plugin purging
end
