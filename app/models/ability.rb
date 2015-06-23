class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    cannot :all, :all

    guest_abilities if user.kind_of? Guest
    logged_in_user_abilities if user.kind_of? User
    manager_abilities if user.manager?
    admin_abilities if user.admin?
  end

  private

  def guest_abilities
    cannot :index, :dashboard
  end

  def logged_in_user_abilities
    cannot :index, :dashboard
    cannot :manage, :balances
    can :create, Order
    can :manage, Order do |order|
      order.pending? && order.user_id == user.id
    end
    can :read, Group
    can :join, Group do |group|
      !UserGroup.where(group: group, user: user).exists?
    end
  end

  def manager_abilities
    can :index, :dashboard
    can [:edit, :update], :balance
    can :new, :menus
    can [:read, :new, :create], MenuSet
    can [:edit, :update], MenuSet do |menu_set|
      menu_set.available_on > Date.today ||
        (menu_set.available_on == Date.today && !Freeze.frozen?)
    end
    can [:pay, :destroy], Order
    can :ready, :lunch
    can :manage, [:freeze, :report]
    can :index, User
    can :read, Activity
  end

  def admin_abilities
    can :manage, :all
  end
end
