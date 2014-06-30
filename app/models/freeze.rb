class Freeze < ActiveRecord::Base
  after_create :set_frozen_on

  scope :today, -> { where frozen_on: Date.current }

  def self.frozen?
    today.exists?
  end

  def self.unfreeze
    today.destroy_all
  end

  private
  def set_frozen_on
    update_column :frozen_on, created_at.to_date
  end
end
