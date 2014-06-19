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
    end
  end
end
