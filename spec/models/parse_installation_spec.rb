require 'rails_helper'

RSpec.describe ParseInstallation, type: :model do
  it 'has a valid factory' do
    expect(create :parse_installation).to be_valid
  end

  describe '.associations' do
    it { is_expected.to belong_to :user }
  end

  describe '.validation' do
    context 'when valid' do
      subject { create :parse_installation }
      it { is_expected.to validate_presence_of :user }
      it { is_expected.to validate_presence_of :parse_object_id }
    end
  end
end
