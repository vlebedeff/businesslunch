require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  subject { Ability.new user }

  describe 'when user is guest' do
    let(:user) { nil }

    it { is_expected.not_to be_able_to :index, :dashboard }
  end

  context 'when user is signed in' do
    let!(:user) { create :user }
    let!(:my_order) { create :order, user: user }
    let!(:order) { create :order }

    it { is_expected.not_to be_able_to :index, :dashboard }
    it { is_expected.to be_able_to :create, Order }
    it { is_expected.to be_able_to :read, my_order }
    it { is_expected.not_to be_able_to :read, order }
  end

  context 'when user is manager' do
    let!(:user) { create :user, :manager }

    it { is_expected.to be_able_to :index, :dashboard }
    it { is_expected.to be_able_to :new, :menus }
    it { is_expected.to be_able_to :read, MenuSet }
    it { is_expected.to be_able_to :manage, MenuSet }
    it { is_expected.to be_able_to :pay, Order }
    it { is_expected.to be_able_to :destroy, Order }
    it { is_expected.to be_able_to :ready, :lunch }
  end
end
