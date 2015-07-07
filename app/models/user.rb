class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  bitmask :roles, as: [:admin]

  belongs_to :current_group, class_name: 'Group'
  has_many :orders, dependent: :destroy
  has_many :user_groups, dependent: :destroy
  has_many :groups, through: :user_groups

  scope :has_order, -> { joins(:orders).merge(Order.today) }
  scope :search, -> term {
    where('email ILIKE ?', "%#{term}%") if term.present?
  }

  def admin?
    roles? :admin
  end

  def manager?
    current_user_group && current_user_group.manager?
  end

  def current_user_group
    user_groups.find_by(group: current_group)
  end

  def super_user?
    manager? || admin?
  end

  def balance
    user_groups.find_by(group: current_group).try(:balance) || 0
  end

  def can_pay_for?(order)
    order &&
      order.pending? &&
      order.user == self &&
      balance >= Order::PRICE &&
      order.group == current_group
  end

  def cannot_pay_for_his_order?(order)
    order &&
      order.pending? &&
      order.user == self &&
      balance < Order::PRICE &&
      order.group == current_group
  end

  def join_group(group)
    user_group = user_groups.create group: group
    update_column :current_group_id, group.id
    user_group
  end

  def leave_group(group)
    ug = user_groups.where(group: group).first
    if ug.balance.zero? && !has_pending_orders?(group)
      ug.try(:destroy)
      update_column :current_group_id, nil
    end
  end

  def change_current_group_to(group)
    if groups.include?(group) && current_group != group
      update_column :current_group_id, group.id
    end
  end

  def today_order
    orders.today.first
  end

  def has_pending_orders?(group)
    orders.pending.where(group: group).exists?
  end
end
