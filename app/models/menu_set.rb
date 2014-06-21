class MenuSet < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { scope: :available_on }
  validates :available_on, presence: true

  scope :available, -> { where(available_on: Date.current) }
end
