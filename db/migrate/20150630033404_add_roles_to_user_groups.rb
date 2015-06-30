class AddRolesToUserGroups < ActiveRecord::Migration
  def change
    add_column :user_groups, :roles, :integer
    add_index :user_groups, :roles
  end
end
