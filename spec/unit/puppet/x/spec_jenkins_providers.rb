require 'spec_helper'

shared_examples 'confines to cli dependencies' do
  describe 'confine' do
    it 'has no matched confines' do
      expect(described_class.confine_collection.summary).to eq({})
    end

    let(:confines) do
      described_class.confine_collection.instance_variable_get(:@confines)
    end

    context 'commands :java' do
      it do
        expect(confines).to include(
          be_kind_of(Puppet::Confine::Exists).
          and(have_attributes(values: ['java']))
        )
      end
    end
  end

  describe 'commands' do
    before do
      allow(described_class).to receive(:command).with(:java).and_return('java')
    end

    context 'java' do
      it { expect(described_class.command(:java)).to eq('java') }
      it { expect(described_class).to respond_to(:java) }
    end
  end
end
