class Report
  attr_reader :begin_on, :end_on

  def initialize(begin_on, end_on)
    @begin_on = begin_on
    @end_on = end_on
  end

  def total
    Order.where(created_on: @begin_on..@end_on).count
  end
end
