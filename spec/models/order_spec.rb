require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'has a valid factory' do
    expect(create :order).to be_valid
  end

  describe '.associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :menu_set }
    it { is_expected.to belong_to :group }
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

  describe '.removable' do
    let!(:today_order) { create :order }
    let!(:yesterday_order) { create :order, created_at: 1.day.ago }

    context 'when orders are frozen' do
      it "retuns empty set" do
        allow(Freeze).to receive(:frozen?).and_return true
        expect(Order.removable).to be_empty
      end
    end

    context 'when order aint frozen' do
      it "returns only today orders" do
        allow(Freeze).to receive(:frozen?).and_return false
        expect(Order.removable).to eq [today_order]
      end
    end
  end

  describe '#removable?' do
    subject { order }

    context 'when it is today order' do
      let!(:order) { create :order }

      context 'when orders is frozen' do
        before { allow(Freeze).to receive(:frozen?).and_return true }
        it { is_expected.not_to be_removable }
      end

      context 'when orders is not frozen' do
        before { allow(Freeze).to receive(:frozen?).and_return false }
        it { is_expected.to be_removable }
      end
    end

    context 'when it is past order' do
      let!(:order) { create :order, created_at: 2.days.ago }
      before { allow(Freeze).to receive(:frozen?).and_return false }
      it { is_expected.not_to be_removable }
    end
  end
end
