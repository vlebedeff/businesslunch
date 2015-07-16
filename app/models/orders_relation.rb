class OrdersRelation
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def from(params)
    return user_orders unless user.super_user?

    if params[:view] == 'all'
      relation
    elsif params[:view] == 'pending'
      relation.pending
    elsif params[:view] == 'paid'
      relation.paid
    else
      user_orders
    end
  end

  private

  def user_orders
    user.orders.where(group: user.current_group)
  end

  def relation
    Order.where(group: user.current_group)
  end
end
