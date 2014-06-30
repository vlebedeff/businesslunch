class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLES = [:manager, :admin]
  bitmask :roles, as: ROLES

  has_many :orders, dependent: :destroy

  scope :has_order, -> { joins(:orders).merge(Order.today) }

  ROLES.each do |role|
    define_method "#{role}?" do
      roles? role
    end
  end
end
