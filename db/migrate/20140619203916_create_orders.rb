class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true, null: false
      t.references :menu_set, index: true, null: false

      t.timestamps
    end
  end
end
