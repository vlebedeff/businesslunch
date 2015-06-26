class AddGroupReferencesToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :group, index: true, foreign_key: true
  end
end
