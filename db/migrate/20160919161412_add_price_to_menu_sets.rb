class AddPriceToMenuSets < ActiveRecord::Migration
  def change
    add_column :menu_sets, :price, :decimal, null: false, default: 35
  end
end
