class AddGroupReferencesToActivities < ActiveRecord::Migration
  def change
    add_reference :activities, :group, index: true, foreign_key: true
  end
end
