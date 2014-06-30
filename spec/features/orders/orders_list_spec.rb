require 'rails_helper'

feature 'Orders list' do
  scenario 'user be able to see his orders' do
    user = create :user_example_com
    order = create :order, user: user

    sign_in_as 'user@example.com'

    expect(current_path).to eq orders_path
    expect(page).to have_content 'Orders'
    expect(page).to have_selector 'a', text: 'Order Now!'
    within "li#order_#{order.id}" do
      expect(page).to have_content order.menu_set_name
    end
  end

  scenario 'user be able to see frozen message' do
    create :user_example_com
    create :freeze

    sign_in_as 'user@example.com'
    visit orders_path

    expect(page).to have_content I18n.t('orders.frozen')
    expect(page).not_to have_selector 'a', text: 'Order Now!'
  end
end
