require_relative '../../app/policies/join_group_policy.rb'

RSpec.describe JoinGroupPolicy, type: :policy do
  describe '#valid?' do
    subject { JoinGroupPolicy.new(group, user) }

    let(:user) { double 'User', email: 'user@example.com' }

    context 'when group has no domain restrictions' do
      let(:group) { double 'Group', domain: '' }
      it { is_expected.to be_valid }
    end

    context 'when group has domain restrictions' do
      context "when user's email is from same domain as group" do
        let(:group) { double 'Group', domain: 'Example.Com' }
        it { is_expected.to be_valid }
      end

      context "when user's email domain is differs from group domain" do
        let(:group) { double 'Group', domain: 'Another-Example.Com' }
        it { is_expected.not_to be_valid }
      end
    end
  end
end
