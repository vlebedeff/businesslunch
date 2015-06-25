class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLES = [:manager, :admin]
  bitmask :roles, as: ROLES

  has_many :orders, dependent: :destroy
  has_many :user_groups, dependent: :destroy
  has_many :groups, through: :user_groups

  validates :balance, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }

  scope :has_order, -> { joins(:orders).merge(Order.today) }
  scope :search, -> term {
    where('email ILIKE ?', "%#{term}%") if term.present?
  }

  ROLES.each do |role|
    define_method "#{role}?" do
      roles? role
    end
  end

  def super_user?
    manager? || admin?
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

  def join_group(group)
    group = user_groups.create group: group
    update_column :current_group_id, group.id
    group
  end

  def leave_group(group)
    user_groups.where(group: group).first.try(:destroy)
    update_column :current_group_id, nil
  end

  def today_order
    orders.today.first
  end
end
