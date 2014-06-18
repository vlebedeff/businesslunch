class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.new_record?
      cannot :all, :all
    else
      can :index, :dashboard
    end
  end
end
