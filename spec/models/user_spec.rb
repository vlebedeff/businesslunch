require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(create :user).to be_valid
  end

  describe '.associations' do
    it { is_expected.to have_many(:orders).dependent :destroy }
    it { is_expected.to have_many(:user_groups).dependent :destroy }
    it { is_expected.to have_many(:groups).through :user_groups }
  end

  describe '.validations' do
    context 'when valid' do
      subject { create :user }
      it { is_expected.to validate_presence_of :balance }
      it do
        is_expected.to validate_numericality_of(:balance)
          .only_integer
          .is_greater_than_or_equal_to(0)
      end
    end
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

    let!(:user) { create :user }
    let!(:order) { create :order, user: user }

    context 'when order belongs to user' do
      context "when user's balance more than order price" do
        let!(:user) { create :user, balance: 40 }

        context 'when order is pending' do
          let!(:order) { create :order, user: user }

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

  describe '#join_group' do
    subject { user.join_group group }

    let!(:user) { create :user }
    let!(:group) { create :group }

    it 'creates new UserGroup record' do
      expect { subject }.to change(UserGroup, :count).by 1
    end
  end

  describe '#leave_group' do
    subject { user.leave_group group }

    let!(:user) { create :user }
    let!(:group) { create :group }

    before do
      create :user_group, user: user, group: group
    end

    it 'leaves group' do
      expect { subject }.to change(UserGroup, :count).by -1
    end
  end
end
