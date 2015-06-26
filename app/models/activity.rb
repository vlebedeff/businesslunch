class Activity < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  belongs_to :subject, polymorphic: true

  validates :group, :user, :subject, :action, presence: true

  delegate :email, to: :user, prefix: true
end
