class AddCurrentGroupIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_group_id, :integer
    add_index :users, :current_group_id
  end
end
