class BalancesController < ApplicationController
  authorize_resource class: false
  before_action :find_user

  def edit
    @balance = Balance.new user: @user
  end

  def update
    @balance = Balance.new safe_params
    if @balance.update
      redirect_to users_path, notice: notice
    else
      render :edit
    end
  end

  private

  def find_user
    @user = User.in_group(current_group).find params[:user_id]
  end

  def notice
    [
      "#{@user.email.split('@').first}'s",
      "balance has been credited with",
      @balance.amount,
      @user.current_group.currency_unit
    ].join ' '
  end

  def safe_params
    {
      user: @user,
      group: current_group,
      manager: current_user,
      amount: params[:balance][:amount]
    }
  end
end
