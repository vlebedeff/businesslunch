class MenuSet < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { scope: :available_on }
  validates :available_on, :price, presence: true

  scope :available, -> { where(available_on: Date.current) }
  scope :recent, -> { where('available_on > ?', 10.days.ago.to_date) }
end
