class MenuSetsController < ApplicationController
  authorize_resource
  before_action :find_menu_set, only: [:edit, :update]

  def index
    @menu_sets = MenuSet.recent.order(available_on: :desc)
  end

  def edit

  end

  def update
    if @menu_set.update_attributes safe_params
      redirect_to menu_sets_path,
        notice: t(:updated_successfully, entity: 'Menu Set')
    else
      render :edit
    end
  end

  private
  def find_menu_set
    @menu_set = MenuSet.find params[:id]
  end

  def safe_params
    params.require(:menu_set).permit(:name, :details)
  end
end
