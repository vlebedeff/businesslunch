class ParseInstallation < ActiveRecord::Base
  belongs_to :user

  validates :user, :parse_object_id, presence: true
end
