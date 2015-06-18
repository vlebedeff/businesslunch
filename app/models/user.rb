class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLES = [:manager, :admin]
  bitmask :roles, as: ROLES

  has_many :orders, dependent: :destroy

  validates :balance, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }

  scope :has_order, -> { joins(:orders).merge(Order.today) }

  ROLES.each do |role|
    define_method "#{role}?" do
      roles? role
    end
  end

  def can_pay_for?(order)
    order &&
      order.pending? &&
      order.user == self &&
      balance >= Order::PRICE
  end

  def cannot_pay_for_his_order?(order)
    order &&
      order.pending? &&
      order.user == self &&
      balance < Order::PRICE
  end

  def today_order
    orders.today.first
  end
end
