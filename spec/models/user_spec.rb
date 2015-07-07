require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(create :user).to be_valid
  end

  describe '.associations' do
    it { is_expected.to belong_to :current_group }
    it { is_expected.to have_many(:orders).dependent :destroy }
    it { is_expected.to have_many(:user_groups).dependent :destroy }
    it { is_expected.to have_many(:groups).through :user_groups }
  end

  describe '.has_order' do
    let!(:user1) { create :user }
    let!(:user2) { create :user }
    let!(:order2) { create :order, user: user2 }
    let!(:user3) { create :user }
    let!(:order3) { create :order, user: user3, created_at: 1.day.ago }

    subject { User.has_order.pluck(:email) }
    it { is_expected.to eq [user2.email] }
  end

  describe '#today_order' do
    let!(:user) { create :user }
    subject { user.today_order }

    context 'when user has today orders' do
      let!(:order) { create :order, user: user }
      it { is_expected.to eq order }
    end

    context 'when user has no today order' do
      it { is_expected.to be_nil }
    end
  end

  describe '#can_pay_for?' do
    subject { user.can_pay_for? order }

    let!(:group) { create :group }
    let!(:user) { create :user, current_group: group }
    let!(:order) { create :order, user: user }

    context 'when order belongs to user' do
      context "when user's balance more than order price" do
        let!(:user) { create :user, current_group: group }

        before do
          create :user_group, user: user, group: group, balance: 40
        end

        context 'when order is pending' do
          let!(:order) { create :order, user: user, group: group }

          it { is_expected.to be_truthy }
        end

        context 'when order is paid' do
          let!(:order) { create :order, :paid, user: user }

          it { is_expected.to be_falsey }
        end
      end

      context "when user's balance less than order price" do
        it { is_expected.to be_falsey }
      end
    end

    context 'when order is blank' do
      let(:order) { nil }

      it { is_expected.to be_falsey }
    end

    context 'when order of different user' do
      let!(:order) { create :order }

      it { is_expected.to be_falsey }
    end
  end

  describe '#balance' do
    subject { user.balance }

    let!(:group) { create :group }

    context 'when user in group' do
      let!(:user) { create :user, current_group: group }

      before do
        create :user_group, user: user, group: group, balance: 503
      end

      it "display balance from current group" do
        is_expected.to eq 503.00
      end
    end

    context 'when user has no group' do
      let!(:user) { create :user }

      it "display empty balance" do
        is_expected.to eq 0.0
      end
    end
  end

  describe '#join_group' do
    subject { user.join_group group }

    let!(:user) { create :user }
    let!(:group) { create :group }

    it 'creates new UserGroup record' do
      expect { subject }.to change(UserGroup, :count).by 1
    end

    it "updates current group id" do
      expect {
        subject
        user.reload
      }.to change { user.current_group_id }.to group.id
    end
  end

  describe '#leave_group' do
    subject { user.leave_group group }

    let!(:group) { create :group }
    let!(:user) { create :user, current_group_id: group.id }

    context 'when user group balance is 0' do
      before do
        create :user_group, user: user, group: group
      end

      it 'leaves group' do
        expect { subject }.to change(UserGroup, :count).by -1
      end

      it "resets current group id" do
        expect {
          subject
          user.reload
        }.to change { user.current_group_id }.to nil
      end
    end

    context 'when user group balance is positive' do
      before do
        create :user_group, user: user, group: group, balance: 1
      end

      it 'cannot leave the group' do
        expect { subject }.not_to change(UserGroup, :count)
      end
    end

    context 'when user has pending orders' do
      before do
        create :user_group, user: user, group: group
        create :order, user: user, group: group
      end

      it 'cannot leave the group' do
        expect { subject }.not_to change(UserGroup, :count)
      end
    end
  end

  describe '#change_current_group_to' do
    subject { user.change_current_group_to group }

    let!(:group) { create :group }

    context 'when user in that group' do
      let!(:user) { create :user, :groupped, group: group }

      it { is_expected.to be_falsey }

      it do
        expect {
          subject
          user.reload
        }.not_to change { user.current_group }
      end
    end

    context 'when user is not joined that group' do
      let!(:user) { create :user }

      it { is_expected.to be_falsey }

      it do
        expect {
          subject
          user.reload
        }.not_to change { user.current_group }
      end
    end

    context 'when user is joined that group' do
      let!(:user) { create :user }

      before { create :user_group, user: user, group: group }

      it { is_expected.to be_truthy }

      it do
        expect {
          subject
          user.reload
        }.to change { user.current_group }.to group
      end
    end
  end
end
