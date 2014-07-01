class Report
  attr_reader :begin_on, :end_on

  def initialize(date_range)
    @date_range = date_range
  end

  def total
    Order.where(created_on: @date_range.from..@date_range.to).count
  end
end
