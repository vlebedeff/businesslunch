require 'rails_helper'

RSpec.describe UserGroup, type: :model do
  it 'has a valid factory' do
    expect(create :user_group).to be_valid
  end

  describe '.associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :group }
  end

  describe '.validations' do
    context 'when valid' do
      subject { create :user_group }
      it { is_expected.to validate_presence_of :user }
      it { is_expected.to validate_presence_of :group }
      it do
        is_expected.to validate_uniqueness_of(:group_id).scoped_to :user_id
      end
    end
  end
end
