class OrdersRelation
  def initialize(user)
    @user = user
  end

  def from(params)
    return @user.orders unless @user.super_user?

    if params[:view] == 'all'
      Order
    elsif params[:view] == 'pending'
      Order.pending
    elsif params[:view] == 'paid'
      Order.paid
    else
      @user.orders
    end
  end
end
