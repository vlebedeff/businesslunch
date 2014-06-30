class OrdersController < ApplicationController
  authorize_resource
  before_action :check_if_not_frozen, only: [:new]
  before_action :find_order, only: [:pay, :destroy]

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
    @order.pay!
    redirect_to dashboard_path
  end

  def destroy
    @order.destroy
    redirect_to dashboard_path
  end

  private
  def order_params
    params.require(:order).permit(:menu_set_id)
  end

  def find_order
    @order = Order.find params[:id]
  end

  def check_if_not_frozen
    if Freeze.frozen_now?
      redirect_to orders_path, alert: t('orders.frozen')
    end
  end
end
