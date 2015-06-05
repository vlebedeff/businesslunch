require 'rails_helper'

RSpec.describe Activity, type: :model do
  it 'has a valid factory' do
    expect(create :activity).to be_valid
  end

  describe '.associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :subject }
  end

  describe '.validations' do
    context 'when valid' do
      subject { create :activity }
      it { is_expected.to validate_presence_of :user }
      it { is_expected.to validate_presence_of :subject }
      it { is_expected.to validate_presence_of :action }
    end
  end
end
