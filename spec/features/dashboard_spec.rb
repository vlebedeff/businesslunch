require 'rails_helper'

feature 'Dashboard' do
  scenario "manager can see list of orders" do
    create :manager_example_com
    order1 = create :order, :paid
    order2 = create :order

    sign_in_as 'manager@example.com'
    visit dashboard_path

    expect(page).to have_content 'Dashboard'
    within 'li', text: order1.menu_set_name do
      expect(page).to have_content 'Paid'
      expect(page).not_to have_selector 'a.btn-success', text: 'Pay'
      expect(page).to have_selector 'a.btn-danger', text: 'Cancel Payment'
    end
    within 'li', text: order2.menu_set_name do
      expect(page).to have_content 'Pending Payment'
      expect(page).to have_selector 'a.btn-success', text: 'Pay'
      expect(page).not_to have_selector 'a.btn-danger', text: 'Cancel Payment'
    end
  end
end
