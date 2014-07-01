class Report
  attr_reader :begin_on, :end_on

  def initialize(params)
    @begin_on = Date.parse [
      params["begin_on(1i)"], params["begin_on(2i)"], params["begin_on(3i)"]
    ].compact.join('-')
    @end_on = Date.parse [
      params["end_on(1i)"], params["end_on(2i)"], params["end_on(3i)"]
    ].compact.join('-')
  end

  def total
    Order.where(created_on: @begin_on..@end_on).count
  end
end
