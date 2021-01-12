require 'spec_helper'
require 'puppet/jenkins'

describe Puppet::Jenkins do
  describe '.home_dir' do
    subject(:home_dir) { described_class.home_dir }

    context "when a jenkins user doesn't exist" do
      before do
        Etc.should_receive(:getpwnam).and_raise(ArgumentError)
      end

      it { is_expected.to eql '/var/lib/jenkins' }
    end

    context 'when a jenkins user does exist' do
      let(:home) { '/rspec/jenkins' }

      before do
        passwd = Etc::Passwd.new('jenkins', '*', 995, 995, '', home, '/sbin/nologin')
        Etc.should_receive(:getpwnam).and_return(passwd)
      end

      it { is_expected.to eql home }
    end
  end
end
