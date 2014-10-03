module Api
  module Docs::Tokens
    extend ActiveSupport::Concern

    included do
      swagger_controller :tokens, 'Authorization via OAuth'

      swagger_api :create do
        summary "Exchange credentials to token"
        param_list :form, :grant_type, :string, :required, 'Grant Type', %w[password]
        param :form, :email, :string, :required, 'Email'
        param :form, :password, :string, :required, 'Password'
        param :form, :client_id, :string, :required, 'Application ID'
        param :form, :client_secret, :string, :required, 'Application Secret Key'
        response :ok, "Success"
        response :unauthorized
      end
    end
  end
end
