class ReportsController < ApplicationController
  authorize_resource class: false

  def new

  end

  def create
    report_dates = DateRange.new(
      DateSelectParser.new("begin_on", params[:report]).to_date,
      DateSelectParser.new("end_on", params[:report]).to_date
    )
    @report = Report.new(report_dates)
    render :show
  end
end
