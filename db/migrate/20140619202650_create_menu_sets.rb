class CreateMenuSets < ActiveRecord::Migration
  def change
    create_table :menu_sets do |t|
      t.string :name, null: false
      t.text :details
      t.date :available_on, null: false

      t.timestamps
    end
  end
end
