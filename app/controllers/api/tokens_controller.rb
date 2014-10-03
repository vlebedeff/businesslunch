module Api
  class TokensController < ::Doorkeeper::TokensController
    include Swagger::Docs::Methods
    include Docs::Tokens

  end
end
