module Api
  module Docs::Menus
    extend ActiveSupport::Concern

    included do
      swagger_controller :menus, 'Menu'

      swagger_api :index do
        summary "Fetches today menu"
        response :ok, "Success"
      end
    end
  end
end
