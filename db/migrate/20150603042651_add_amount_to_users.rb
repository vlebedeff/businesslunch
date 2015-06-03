class AddAmountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :amount, :integer, default: 0
  end
end
