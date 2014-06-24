class MenuSetsController < ApplicationController
  authorize_resource


  def index
    @menu_sets = MenuSet.order(available_on: :desc)
  end
end
