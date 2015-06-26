class Freeze < ActiveRecord::Base
  belongs_to :group

  after_create :set_frozen_on

  scope :today, -> { where frozen_on: Date.current }

  def self.frozen?(group)
    where(group: group).today.exists?
  end

  def self.unfreeze(group)
    where(group: group).today.destroy_all
  end

  private

  def set_frozen_on
    update_column :frozen_on, created_at.to_date
  end
end
