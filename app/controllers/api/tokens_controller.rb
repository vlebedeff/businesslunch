module Api
  class TokensController < ::Doorkeeper::TokensController
    include Swagger::Docs::Methods
    include Docs::Tokens

    def create
      super
      create_parse_installation
    end

    protected
    def create_parse_installation
      ParseInstallation.first_or_create(
        user: strategy.request.resource_owner,
        parse_object_id: params[:parse_object_id])
    end
  end
end
