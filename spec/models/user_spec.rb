require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(create :user).to be_valid
  end

  describe '.associations' do
    it { is_expected.to have_many(:orders).dependent :destroy }
  end

  describe '.validations' do
    context 'when valid' do
      subject { create :user }
      it { is_expected.to validate_presence_of :amount }
      it do
        is_expected.to validate_numericality_of(:amount)
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

  describe '#full_name' do
    let(:user) { create :user, email: 'bruce.wayne@example.com' }
    subject { user.full_name }
    it { is_expected.to eq 'Bruce Wayne' }
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
end
