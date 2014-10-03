module Api
  class MenusController < ApiController
    include Docs::Menus

    def index
      @menu_sets = MenuSet.available
    end
  end
end
