require 'spec_helper'

describe 'jenkins::cli::config' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      shared_examples 'validate_absolute_path' do |param|
        context 'absolute path' do
          let(:params) { { param => '/dne' } }

          it { is_expected.to compile }
        end
      end # validate_absolute_path

      shared_examples 'validate_integer' do |param|
        context 'integer' do
          let(:params) { { param => 42 } }

          it { is_expected.to compile }
        end
      end # validate_integer

      shared_examples 'validate_numeric' do |param|
        context 'integer' do
          let(:params) { { param => 42 } }

          it { is_expected.to compile }
        end

        context 'float' do
          let(:params) { { param => 42.12345 } }

          it { is_expected.to compile }
        end
      end # validate_numeric

      shared_examples 'validate_string' do |param|
        context 'string' do
          let(:params) { { param => 'foo' } }

          it { is_expected.to compile }
        end
      end # validate_string

      describe 'parameters' do
        context 'accept all params undef' do
          it { is_expected.to compile }
        end

        describe 'cli_jar' do
          it_behaves_like 'validate_absolute_path', :cli_jar
        end

        # context 'port' do
        #   it_behaves_like 'validate_integer', :port
        # end
        context 'url' do
          it_behaves_like 'validate_string', :url
        end

        context 'ssh_private_key' do
          it_behaves_like 'validate_absolute_path', :ssh_private_key
        end

        context 'puppet_helper' do
          it_behaves_like 'validate_absolute_path', :puppet_helper
        end

        context 'cli_tries' do
          it_behaves_like 'validate_integer', :cli_tries
        end

        context 'cli_try_sleep' do
          it_behaves_like 'validate_numeric', :cli_try_sleep
        end

        context 'ssh_private_key_content' do
          it_behaves_like 'validate_string', :ssh_private_key_content

          context 'when ssh_private_key is also set' do
            let(:params) do
              {
                ssh_private_key: '/dne',
                ssh_private_key_content: 'foo'
              }
            end

            context 'as non-root user' do
              let :facts do
                super().merge(id: 'user')
              end

              it do
                is_expected.to contain_file('/dne').with(
                  ensure: 'file',
                  mode: '0400',
                  backup: false,
                  owner: nil,
                  group: nil
                )
              end
              it { is_expected.to contain_file('/dne').with_content('foo') }
            end # as non-root user

            context 'as root' do
              let :facts do
                super().merge(id: 'root')
              end

              it do
                is_expected.to contain_file('/dne').with(
                  ensure: 'file',
                  mode: '0400',
                  backup: false,
                  owner: 'jenkins',
                  group: 'jenkins'
                )
              end
              it { is_expected.to contain_file('/dne').with_content('foo') }
            end # as root
          end # when ssh_private_key is also set
        end # ssh_private_key_content
      end # parameters
    end
  end
end
