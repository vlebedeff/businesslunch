class AddDomainToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :domain, :string
  end
end
