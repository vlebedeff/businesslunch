class OrdersController < ApplicationController
  authorize_resource

  def index
    @orders = current_user.orders.includes(:menu_set).order(:created_at)
  end

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.new order_params
    if @order.save
      redirect_to orders_path,
        notice: t(:order_created, menu_set: @order.menu_set_name)
    else
      render :new
    end
  end

  def pay
    Order.find(params[:id]).pay!
    redirect_to dashboard_path
  end

  private
  def order_params
    params.require(:order).permit(:menu_set_id)
  end
end
