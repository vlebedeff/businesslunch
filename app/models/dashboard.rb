class Dashboard
  attr_reader :user, :relation

  def initialize(user)
    @user = user
    @relation = Order.where(group: user.current_group)
  end

  def current_counters
    counters = {}
    MenuSet.available.each do |menu_set|
      counters[menu_set.name] = OpenStruct.new(
        count: relation.today.where(menu_set_id: menu_set.id).count,
        details: menu_set.details
      )
    end

    counters['Total'] = OpenStruct.new(count: relation.today.count)

    counters
  end

  def orders
    relation.joins(:menu_set, :user).recent.order('users.email')
  end
end
