class ReportsController < ApplicationController
  authorize_resource class: false

  def new

  end

  def create
    begin_on = DateSelectParser.new("begin_on", params[:report]).to_date
    end_on = DateSelectParser.new("end_on", params[:report]).to_date
    @report = Report.new(begin_on, end_on)
    render :show
  end
end
