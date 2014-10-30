module Api
  class OrdersController < ApiController
    include Docs::Orders

    doorkeeper_for :all
    before_action :check_if_not_frozen, only: [:create]

    def index
      @orders = OrdersQuery.new(current_resource_owner.orders).all.limit(10)
    end

    def create
      order = Order.new order_params
      if order.save
        render json: {}, status: :created
      else
        render json: order.errors, status: :unprocessable_entity
      end
    end

    def destroy
      order = current_resource_owner.orders.find params[:id]
      order.destroy
      render json: {}, status: :no_content
    end

    private
    def order_params
      {
        user: current_resource_owner,
        menu_set: MenuSet.available.find_by(id: params[:order][:menu_set_id])
      }
    end

    def check_if_not_frozen
      if Freeze.frozen?
        render json: { orders: ["are frozen"] }, status: :unprocessable_entity
      end
    end
  end
end
