require 'rails_helper'

feature 'Dashboard' do
  scenario "manager can see list of orders" do
    create :manager_example_com
    order1 = create :order, :paid
    order2 = create :order

    sign_in_as 'manager@example.com'
    visit dashboard_path

    expect(page).to have_content 'Dashboard'
    expect(page).to have_selector 'li', text: "#{order1.menu_set_name} Paid"
    expect(page).to have_selector 'li', text: "#{order2.menu_set_name} Pending Payment"
    expect(page).to have_content order2.menu_set_name
  end
end
