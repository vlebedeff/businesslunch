class RenameUsersAmountToUsersBlance < ActiveRecord::Migration
  def change
    rename_column :users, :amount, :balance
  end
end
