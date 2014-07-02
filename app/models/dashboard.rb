class Dashboard
  def current_counters
    counters = {}
    MenuSet.available.each do |menu_set|
      counters[menu_set.name] = Order.today.where(menu_set_id: menu_set.id).count
    end

    counters['Total'] = Order.today.count

    counters
  end

  def orders
    Order.joins(:menu_set, :user).recent.order('users.email')
  end
end
