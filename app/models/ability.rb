class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    cannot :all, :all

    if user.new_record?
      cannot :index, :dashboard
    end

    if user.persisted?
      cannot :index, :dashboard
      can :create, Order
      can :manage, Order do |order|
        order.user_id == user.id
      end
    end

    if user.manager?
      can :index, :dashboard
      can :new, :menus
      can [:read, :new, :create], MenuSet
      can [:edit, :update], MenuSet do |menu_set|
        menu_set.available_on > Date.today ||
          (menu_set.available_on == Date.today && !Freeze.frozen?)
      end
      can [:pay, :destroy], Order
      can :ready, :lunch
      can :manage, [:freeze, :report]
    end
  end
end
