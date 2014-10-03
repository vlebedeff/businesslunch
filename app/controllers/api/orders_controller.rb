module Api
  class OrdersController < ApiController
    include Docs::Orders

    doorkeeper_for :all

    def create
      order = Order.new order_params
      if order.save
        render json: {}, status: :created
      else
        render json: order.errors, status: :unprocessable_entity
      end
    end

    private
    def order_params
      {
        user: current_resource_owner,
        menu_set: MenuSet.available.find_by(id: params[:order][:menu_set_id])
      }
    end
  end
end
