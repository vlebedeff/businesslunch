require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  describe 'when user is guest' do
    subject { Ability.new nil }

    it { is_expected.not_to be_able_to :index, :dashboard }
  end

  context 'when user is signed in' do
    let!(:user) { create :user }
    let!(:my_order) { create :order, user: user }
    let!(:order) { create :order }
    subject { Ability.new user }

    it { is_expected.to be_able_to :index, :dashboard }
    it { is_expected.to be_able_to :create, Order }
    it { is_expected.to be_able_to :read, my_order }
    it { is_expected.not_to be_able_to :read, order }
  end
end
