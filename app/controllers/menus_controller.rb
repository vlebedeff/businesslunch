class MenusController < ApplicationController
  def new
    authorize! :new, :menus
    @menu = Menu.new(
      available_on: Date.current,
      menu_sets: [
        MenuSet.new(name: '1st menu set'),
        MenuSet.new(name: '2nd menu set'),
        MenuSet.new(name: 'Diet menu set')
      ]
    )
  end

  def create
    @menu = Menu.from_params params[:menu]
    if @menu.save
      redirect_to menu_sets_path
    else
      render :new
    end
  end
end
