class Report
  attr_reader :from, :to

  def initialize(dates)
    @from = dates.from
    @to = dates.to
  end

  def total
    orders.count
  end

  def orders
    Order.where(created_on: @from..@to)
  end
end
