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
    group_abilities
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
    group_abilities
  end

  def admin_abilities
    can :manage, :all
    group_abilities
  end

  def group_abilities
    can :read, Group
    cannot [:join, :leave, :make_current], Group
    can :join, Group do |group|
      !UserGroup.where(group_id: group.id, user_id: user.id).exists?
    end
    can :leave, Group do |group|
      UserGroup.where(group_id: group.id, user_id: user.id).exists?
    end
    can :make_current, Group do |group|
      user.groups.include?(group) && user.current_group != group
    end
  end
end
