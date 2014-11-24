class OrdersController < ApplicationController
  authorize_resource
  before_action :check_balance, only: [:create]
  before_action :check_if_not_frozen, only: [:new, :create]
  before_action :find_order, only: [:pay, :cancel_payment, :destroy, :pay_from_balance]

  def index
    relation = OrdersRelation.new(current_user).from(params)
    @orders = OrdersQuery.new(relation).all.page(params[:page])
  end

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.new order_params
    if @order.save
      PayFromBalance.call @order, current_user
      redirect_to orders_path,
        notice: t(:order_created, menu_set: @order.menu_set_name)
    else
      render :new
    end
  end

  def pay
    @order.pay!
    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.js
    end
  end

  def cancel_payment
    @order.cancel_payment!
    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.js { render 'pay' }
    end
  end

  def pay_from_balance
    if PayFromBalance.call(@order, current_user)
      flash[:notice] = t('balance.paid_successfully')
    end

    redirect_to :back
  end

  def destroy
    Order.removable.find(params[:id]).destroy
    redirect_to :back
  end

  private

  def order_params
    params.require(:order).permit(:menu_set_id)
      .merge(group: current_user.current_group)
  end

  def find_order
    @order = Order.find params[:id]
  end

  def check_if_not_frozen
    if Freeze.frozen?(current_user.current_group)
      redirect_to orders_path, alert: t('orders.frozen')
    end
  end

  def check_balance
    unless current_user.has_positive_balance? current_group
      redirect_to new_order_path, alert: t('orders.negative_balance')
    end
  end
end
