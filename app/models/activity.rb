class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject, polymorphic: true

  validates :user, :subject, :action, presence: true

  delegate :email, to: :user, prefix: true
end
