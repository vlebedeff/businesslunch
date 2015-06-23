require 'rails_helper'

RSpec.describe Group, type: :model do
  it 'has a valid factory' do
    expect(create :group).to be_valid
  end

  describe '.validations' do
    context 'when valid' do
      subject { create :group }
      it { is_expected.to validate_presence_of :name }
      it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
    end
  end
end
