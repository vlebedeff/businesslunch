require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'has a valid factory' do
    expect(create :order).to be_valid
  end

  describe '.associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :menu_set }
  end

  describe '.validations' do
    context 'when valid' do
      subject { create :order }
      it { is_expected.to validate_presence_of :user }
      it { is_expected.to validate_presence_of :menu_set }
      it { is_expected.to validate_presence_of :state }
      it do
        is_expected.to ensure_inclusion_of(:state).in_array %w[pending paid]
      end
    end
  end

  describe 'after_create' do
    let(:order) { build :order }
    it "creates order with created_on date" do
      expect {
        order.save
        order.reload
      }.to change { order.created_on }
    end
  end
end
