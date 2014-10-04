module Api
  class MenusController < ApiController
    include Docs::Menus

    doorkeeper_for :all

    def index
      @menu_sets = MenuQuery.if_not_frozen
    end
  end
end
