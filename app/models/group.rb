class Group < ActiveRecord::Base
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
