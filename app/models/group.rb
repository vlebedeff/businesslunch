# TODO: Add valid group id to all orders
# TODO: Add user's to same group
# TODO: Move balance to user_group

class Group < ActiveRecord::Base
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups
  has_many :orders, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
