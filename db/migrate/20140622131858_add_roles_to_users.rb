class AddRolesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :roles, :integer
    add_index :users, :roles
  end
end
