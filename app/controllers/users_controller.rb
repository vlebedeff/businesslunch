class UsersController < ApplicationController
  authorize_resource

  def index
    @users = User.search(params[:query]).order(:email).page(params[:page])
  end
end
