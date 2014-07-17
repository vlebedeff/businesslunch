class OrdersQuery
  def initialize(relation = Order)
    @relation = relation.includes(:menu_set)
  end

  def all
    @relation.order(created_at: :desc)
  end
end
