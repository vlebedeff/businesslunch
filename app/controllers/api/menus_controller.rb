module Api
  class MenusController < ApiController
    def index
      @menu_sets = MenuSet.available
    end
  end
end
