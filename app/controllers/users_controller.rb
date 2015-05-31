class UsersController < ApplicationController
  authorize_resource

  def index
    @users = User.order(:email).page(params[:page])
  end
end
