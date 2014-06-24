class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :menu_set

  validates :user, :menu_set, presence: true
  validates :state, presence: true, inclusion: { in: %w[pending paid] }

  delegate :name, to: :menu_set, prefix: true
  delegate :email, to: :user, prefix: true

  scope :today, -> {
    where(created_at: DateTime.current.beginning_of_day..DateTime.current.end_of_day)
  }
end
