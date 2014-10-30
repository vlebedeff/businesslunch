class CreateParseInstallations < ActiveRecord::Migration
  def change
    create_table :parse_installations do |t|
      t.references :user, index: true, null: false
      t.string :parse_object_id, null: false

      t.timestamps
    end
    add_index :parse_installations, :parse_object_id
  end
end
