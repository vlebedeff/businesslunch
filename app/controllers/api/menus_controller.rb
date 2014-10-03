module Api
  class MenusController < ApiController
    include Docs::Menus

    doorkeeper_for :all

    def index
      @menu_sets = MenuSet.available
    end
  end
end
