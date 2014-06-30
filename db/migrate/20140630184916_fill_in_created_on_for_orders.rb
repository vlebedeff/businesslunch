class FillInCreatedOnForOrders < ActiveRecord::Migration
  def up
    say_with_time "Updating created_on for orders" do
      Order.find_each do |order|
        order.update_column :created_on, order.created_at.to_date
      end
    end
  end

  def down
  end
end
