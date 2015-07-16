class AddBalanceToUserGroups < ActiveRecord::Migration
  def change
    add_column :user_groups, :balance, :decimal, precision: 8, scale: 2, default: 0
  end
end
