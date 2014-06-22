class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :menu_set

  validates :user, :menu_set, presence: true

  delegate :name, to: :menu_set, prefix: true
  delegate :email, to: :user, prefix: true
end
