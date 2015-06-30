class AddCurrencyUnitToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :currency_unit, :string
  end
end
