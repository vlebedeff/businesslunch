class ReportsController < ApplicationController
  authorize_resource class: false

  def new

  end

  def create
    @report = Report.new(params[:report])
    render :show
  end
end
