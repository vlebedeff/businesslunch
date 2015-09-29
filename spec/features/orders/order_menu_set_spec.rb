require 'rails_helper'

feature 'Ordering Menu Set' do
  context 'when there is menu sets for today' do
    scenario 'can make an order' do
      user = create :user_example_com, :groupped, balance: Order::PRICE
      create :menu_set, name: '1st menu set'

      sign_in_as 'user@example.com'

      click_link 'Order Now!'
      within '#new_order' do
        choose '1st menu set'
        click_button 'Order'
      end

      expect(page).to have_content "You have ordered \"1st menu set\""
      expect(Order.last.group).to eq user.current_group
      expect(Order.last).to be_paid
    end
  end

  context 'when there is no menu sets' do
    scenario 'cannot make an order' do
      create :user_example_com, :groupped

      sign_in_as 'user@example.com'
      visit new_order_path

      expect(page).to have_content 'There is no menu sets for today'
    end
  end

  context 'when orders are frozen for today' do
    scenario 'cannot create an order' do
      user = create :user_example_com, :groupped
      create :freeze, group: user.current_group

      sign_in_as 'user@example.com'
      visit new_order_path

      expect(page).to have_content 'Orders are frozen for today. You are not be able to manage them.'
      expect(current_path).to eq orders_path
    end
  end

  context "when there is no funds on user's account" do
    scenario "cannot create an order" do
      user = create :user_example_com, :groupped
      create :menu_set, name: '1st menu set'
      orders_count = user.orders.count

      sign_in_as 'user@example.com'
      visit new_order_path
      click_button 'Create Order'

      expect(page).to have_content "You have insufficient funds to place an order!"
      user.reload
      expect(user.orders.count).to eq orders_count
    end
  end
end
