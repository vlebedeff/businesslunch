class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :menu_set

  validates :user, :menu_set, presence: true
end
