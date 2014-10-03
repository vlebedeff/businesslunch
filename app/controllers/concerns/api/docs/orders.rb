module Api
  module Docs::Orders
    extend ActiveSupport::Concern

    included do
      swagger_controller :orders, 'Orders'

      swagger_api :index do
        summary "Retrieves list of last 10 orders"
        param :query, :access_token, :string, :requred, 'Access Token'
        response :unauthorized
        response :ok, "Success"
      end

      swagger_api :create do
        summary "Creates new order"
        param :form, :access_token, :string, :required, 'Access Token'
        param :form, "order[menu_set_id]", :string, :required, "Available Menu Set ID"
        response :unauthorized
        response :created
        response :unprocessable_entity
      end
    end
  end
end
