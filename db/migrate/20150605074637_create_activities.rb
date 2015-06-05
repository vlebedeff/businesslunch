class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :user, index: true, null: false
      t.string :action, null: false
      t.references :subject, polymorphic: true, index: true, null: false
      t.string :data

      t.timestamps
    end
  end
end
