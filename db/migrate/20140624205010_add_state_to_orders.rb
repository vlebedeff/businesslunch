class AddStateToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :state, :string, null: 'false', default: 'pending'
  end
end
