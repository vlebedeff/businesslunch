require 'rails_helper'

feature 'Orders list' do
  scenario 'user be able to see his orders' do
    user = create :user_example_com
    order = create :order, user: user

    sign_in_as 'user@example.com'

    expect(current_path).to eq orders_path
    expect(page).to have_content 'Orders'
    within "li#order_#{order.id}" do
      expect(page).to have_content order.menu_set_name
    end
  end
end
