class Group < ActiveRecord::Base
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups
  has_many :orders, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :currency_unit, presence: true
end
