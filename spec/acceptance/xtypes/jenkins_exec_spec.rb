require 'spec_helper_acceptance'

describe 'jenkins_exec' do
  include_context 'jenkins'

  context 'logout =>' do
    context 'true' do
      it 'should work with no errors' do
        pp = base_manifest + <<-EOS
          jenkins_exec { 'this is a test':
            script    => 'out.println("of the emergency...")',
            logoutput => true,
          }
        EOS

        output = apply_manifest(pp, :catch_failures => true)

        expect(output.stdout).to match(/this is a test/)
        expect(output.stdout).to match(/of the emergency.../)
      end
    end # context 'true'

    context 'false' do
      it 'should work with no errors' do
        pp = base_manifest + <<-EOS
          jenkins_exec { 'this is a test':
            script    => 'out.println("of the emergency...")',
            logoutput => false,
          }
        EOS

        output = apply_manifest(pp, :catch_failures => true)

        expect(output.stdout).to match(/this is a test/)
        expect(output.stdout).to_not match(/of the emergency.../)
      end

      it 'should fail' do
        pp = base_manifest + <<-EOS
          jenkins_exec { 'this is a test':
            script    => 'new Dne()',
            logoutput => false,
          }
        EOS

        output = apply_manifest(pp, :catch_failures => false)

        expect(output.stderr).to_not match(/ ERROR: Unexpected exception occurred while performing groovy command/)
      end
    end # context 'false'

    context 'on_failure' do
      it 'should work with no errors' do
        pp = base_manifest + <<-EOS
          jenkins_exec { 'this is a test':
            script    => 'out.println("of the emergency...")',
            logoutput => 'on_failure',
          }
        EOS

        output = apply_manifest(pp, :catch_failures => true)

        expect(output.stdout).to match(/this is a test/)
        expect(output.stdout).to_not match(/of the emergency.../)
      end

      it 'should fail' do
        pp = base_manifest + <<-EOS
          jenkins_exec { 'this is a test':
            script    => 'new Dne()',
            logoutput => 'on_failure',
          }
        EOS

        output = apply_manifest(pp, :catch_failures => false)

        expect(output.stderr).to match(/ ERROR: Unexpected exception occurred while performing groovy command/)
      end
    end # context 'on_failure'
  end # context 'logout =>'

  context 'returns =>' do
    context '0' do
      it 'should work with no errors' do
        pp = base_manifest + <<-EOS
          jenkins_exec { 'this is a test':
            script  => 'out.println("of the emergency...")',
            returns => 0, # default
          }
        EOS

        output = apply_manifest(pp, :catch_failures => true)
        expect(output.exit_code).to eq 0
      end
    end # context '0'

    context '1' do
      it 'should fail' do
        pp = base_manifest + <<-EOS
          jenkins_exec { 'this is a test':
            script  => 'out.println("of the emergency..."); new Dne()',
            returns => 1,
          }
        EOS

        output = apply_manifest(pp, :catch_failures => false)
        expect(output.exit_code).to eq 1
      end
    end # context '1'
  end # context 'returns =>'
end
