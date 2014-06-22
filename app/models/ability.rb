class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    cannot :all, :all

    if user.new_record?
      cannot :index, :dashboard
    elsif user.manager?
      can :index, :dashboard
    else
      cannot :index, :dashboard
      can :create, Order
      can :read, Order do |order|
        order.user_id == user.id
      end
    end
  end
end
