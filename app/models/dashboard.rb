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
    Order.includes(:menu_set, :user).order(created_at: :desc)
  end
end
