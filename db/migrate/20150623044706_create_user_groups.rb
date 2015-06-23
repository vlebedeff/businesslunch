class CreateUserGroups < ActiveRecord::Migration
  def change
    create_table :user_groups do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.references :group, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
