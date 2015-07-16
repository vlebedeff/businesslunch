require 'rails_helper'

RSpec.describe Group, type: :model do
  it 'has a valid factory' do
    expect(create :group).to be_valid
  end

  describe '.associations' do
    it { is_expected.to have_many(:user_groups).dependent :destroy }
    it { is_expected.to have_many(:users).through(:user_groups) }
    it { is_expected.to have_many(:orders).dependent :destroy }
  end

  describe '.validations' do
    context 'when valid' do
      subject { create :group }
      it { is_expected.to validate_presence_of :name }
      it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
      it { is_expected.to validate_presence_of :currency_unit }
    end
  end
end
