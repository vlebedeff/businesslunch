class DashboardController < ApplicationController
  authorize_resource class: false

  def index
    @dashboard = Dashboard.new current_user
  end
end
