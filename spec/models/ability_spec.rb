require 'rails_helper'
require 'cancan/matchers'

shared_examples 'group abilities' do
  let!(:group) { create :group }

  context 'when user is not a member of the group' do

    it 'are able to join the group' do
      is_expected.to be_able_to :join, group
    end

    it 'are not be able to leave group' do
      is_expected.not_to be_able_to :leave, group
    end
  end

  context 'when user is a member of the group' do

    it 'are not able to join group' do
      create :user_group, user: user, group: group
      is_expected.not_to be_able_to :join, group
    end

    context 'when user group balance is zero' do
      before { create :user_group, user: user, group: group }

      it 'are able to leave group' do
        is_expected.to be_able_to :leave, group
      end
    end

    context 'when user group balance is not empty' do
      before { create :user_group, user: user, group: group, balance: 1 }

      it 'are not able to leave group' do
        is_expected.not_to be_able_to :leave, group
      end
    end

    context 'when user has pending orders' do
      before do
        create :user_group, user: user, group: group
        create :order, user: user, group: group
      end

      it 'are not able to leave group' do
        is_expected.not_to be_able_to :leave, group
      end
    end
  end

  context 'when user is joined group' do
    context 'when user current group is different group' do
      let!(:user) { create :user, :groupped }

      before do
        create :user_group, user: user, group: group
      end

      it 'can make group as current' do
        is_expected.to be_able_to :make_current, group
      end
    end

    context 'when user current group is the same group' do
      let!(:user) { create :user, :groupped, group: group }

      it 'cannot make same group current' do
        is_expected.not_to be_able_to :make_current, group
      end
    end
  end
end

RSpec.describe Ability, type: :model do
  subject { Ability.new user }

  describe 'when user is guest' do
    let(:user) { Guest.new }

    it { is_expected.not_to be_able_to :index, :dashboard }
  end

  context 'when user is signed in' do
    let!(:user) { create :user }
    let!(:my_order) { create :order, user: user }
    let!(:my_paid_order) { create :order, :paid, user: user }
    let!(:order) { create :order }

    it { is_expected.not_to be_able_to :index, :dashboard }
    it { is_expected.to be_able_to :create, Order }
    it { is_expected.to be_able_to :read, my_order }
    it { is_expected.to be_able_to :manage, my_order }
    it { is_expected.not_to be_able_to :manage, my_paid_order }
    it { is_expected.not_to be_able_to :manage, order }
    it { is_expected.not_to be_able_to :ready, :lunch }
    it { is_expected.not_to be_able_to :manage, :freeze }
    it { is_expected.not_to be_able_to :manage, :report }
    it { is_expected.not_to be_able_to :index, User }
    it { is_expected.not_to be_able_to :all, :balance }
    it { is_expected.not_to be_able_to :all, Activity }
    it { is_expected.to be_able_to :read, Group }
    it_behaves_like 'group abilities'
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
    it_behaves_like 'group abilities'

    context 'when orders are frozen' do
      let!(:freeze) { create :freeze, group: user.current_group }
      let!(:future_menu_set) { create :menu_set, available_on: 1.day.from_now }
      it { is_expected.to be_able_to :edit, future_menu_set }
      it { is_expected.to be_able_to :update, future_menu_set }
      it { is_expected.not_to be_able_to :edit, menu_set }
      it { is_expected.not_to be_able_to :update, menu_set }
    end
  end

  context 'when user is admin' do
    let!(:user) { create :user, :admin }
    it 'he is almighty' do
      is_expected.to be_able_to :all, :all
    end
    it { is_expected.to be_able_to :read, Vendor }
    it_behaves_like 'group abilities'
  end
end
