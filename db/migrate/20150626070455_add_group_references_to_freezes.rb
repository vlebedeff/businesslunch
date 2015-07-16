class AddGroupReferencesToFreezes < ActiveRecord::Migration
  def change
    add_reference :freezes, :group, index: true, foreign_key: true
  end
end
