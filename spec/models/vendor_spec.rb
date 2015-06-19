require 'rails_helper'

RSpec.describe Vendor, type: :model do
  it 'has a valid factory' do
    expect(create :vendor).to be_valid
  end

  describe '.validations' do
    context 'when valid' do
      subject { create :vendor }
      it { is_expected.to validate_presence_of :name }
      it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
    end
  end
end
