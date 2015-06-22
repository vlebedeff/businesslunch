class UsersController < ApplicationController
  authorize_resource

  def index
    @users = User.search(params[:query]).order(:email).page(params[:page])
  end

  def destroy
    user = User.find params[:id]
    user.destroy if user.balance.zero?
    redirect_to :back
  end
end
