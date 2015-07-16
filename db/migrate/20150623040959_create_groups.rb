class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
    add_index :groups, :name, unique: true
  end
end
