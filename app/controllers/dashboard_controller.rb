class DashboardController < ApplicationController
  authorize_resource class: false

  def index
    @orders = Order.includes(:menu_set, :user).order(:created_at)
  end
end
