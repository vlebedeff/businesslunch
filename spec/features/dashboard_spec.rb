require 'rails_helper'

feature 'Dashboard' do
  scenario "manager can see list of orders" do
    create :manager_example_com
    order1 = create :order
    order2 = create :order

    sign_in_as 'manager@example.com'
    visit dashboard_path

    expect(page).to have_content 'Dashboard'
    expect(page).to have_content order1.menu_set_name
    expect(page).to have_content order2.menu_set_name
  end
end
