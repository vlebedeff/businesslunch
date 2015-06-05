class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject, polymorphic: true

  validates :user, :subject, :action, presence: true
end
