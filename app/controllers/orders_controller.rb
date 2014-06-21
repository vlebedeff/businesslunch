class OrdersController < ApplicationController
  authorize_resource

  def index

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

  private
  def order_params
    params.require(:order).permit(:menu_set_id)
  end
end
