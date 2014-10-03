module Api
  module Docs::Menus
    extend ActiveSupport::Concern

    included do
      swagger_controller :menus, 'Menu'

      swagger_api :index do
        summary "Fetches today menu"
        param :query, :access_token, :string, :required, 'Access Token'
        response :ok, "Success"
      end
    end
  end
end
