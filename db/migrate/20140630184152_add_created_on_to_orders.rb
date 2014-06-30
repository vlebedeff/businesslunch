class AddCreatedOnToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :created_on, :date
    add_index :orders, :created_on
  end
end
