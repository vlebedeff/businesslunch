require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  describe 'when user is guest' do
    subject { Ability.new nil }

    it { is_expected.not_to be_able_to :index, :dashboard }
  end

  context 'when user is signed in' do
    let!(:user) { create :user }
    subject { Ability.new user }

    it { is_expected.to be_able_to :index, :dashboard }
  end
end
