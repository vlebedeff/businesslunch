class Freeze < ActiveRecord::Base
  after_create :set_frozen_on

  def self.frozen_now?
    where(frozen_on: Date.current).exists?
  end

  private
  def set_frozen_on
    update_column :frozen_on, created_at.to_date
  end
end
