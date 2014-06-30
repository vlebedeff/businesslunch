class CreateFreezes < ActiveRecord::Migration
  def change
    create_table :freezes do |t|
      t.date :frozen_on

      t.timestamps
    end
    add_index :freezes, :frozen_on
  end
end
