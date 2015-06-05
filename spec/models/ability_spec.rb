require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  subject { Ability.new user }

  describe 'when user is guest' do
    let(:user) { Guest.new }

    it { is_expected.not_to be_able_to :index, :dashboard }
  end

  context 'when user is signed in' do
    let!(:user) { create :user }
    let!(:my_order) { create :order, user: user }
    let!(:order) { create :order }

    it { is_expected.not_to be_able_to :index, :dashboard }
    it { is_expected.to be_able_to :create, Order }
    it { is_expected.to be_able_to :read, my_order }
    it { is_expected.to be_able_to :manage, my_order }
    it { is_expected.not_to be_able_to :manage, order }
    it { is_expected.not_to be_able_to :ready, :lunch }
    it { is_expected.not_to be_able_to :manage, :freeze }
    it { is_expected.not_to be_able_to :manage, :report }
    it { is_expected.not_to be_able_to :index, User }
    it { is_expected.not_to be_able_to :all, :balance }
    it { is_expected.not_to be_able_to :all, Activity }
  end

  context 'when user is manager' do
    let!(:user) { create :user, :manager }
    let!(:past_menu_set) { create :menu_set, available_on: 1.day.ago }
    let!(:menu_set) { create :menu_set }

    it { is_expected.to be_able_to :index, :dashboard }
    it { is_expected.to be_able_to :new, :menus }
    it { is_expected.to be_able_to :read, MenuSet }
    it { is_expected.to be_able_to :new, MenuSet }
    it { is_expected.to be_able_to :create, MenuSet }
    it { is_expected.to be_able_to :edit, menu_set }
    it { is_expected.to be_able_to :update, menu_set }
    it { is_expected.not_to be_able_to :edit, past_menu_set }
    it { is_expected.not_to be_able_to :update, past_menu_set }
    it { is_expected.to be_able_to :pay, Order }
    it { is_expected.to be_able_to :destroy, Order }
    it { is_expected.to be_able_to :ready, :lunch }
    it { is_expected.to be_able_to :manage, :freeze }
    it { is_expected.to be_able_to :manage, :report }
    it { is_expected.to be_able_to :index, User }
    it { is_expected.to be_able_to :edit, :balance }
    it { is_expected.to be_able_to :update, :balance }
    it { is_expected.to be_able_to :read, Activity }

    context 'when orders are frozen' do
      let!(:freeze) { create :freeze }
      let!(:future_menu_set) { create :menu_set, available_on: 1.day.from_now }
      it { is_expected.to be_able_to :edit, future_menu_set }
      it { is_expected.to be_able_to :update, future_menu_set }
      it { is_expected.not_to be_able_to :edit, menu_set }
      it { is_expected.not_to be_able_to :update, menu_set }
    end
  end
end
