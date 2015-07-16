require 'rails_helper'

feature 'Dashboard' do
  scenario "manager can see list of orders" do
    manager = create :manager_example_com
    order1 = create :order, :paid, group: manager.current_group
    order2 = create :order, group: manager.current_group

    sign_in_as 'manager@example.com'
    visit dashboard_path

    expect(page).to have_content 'Dashboard'
    within 'li', text: order1.menu_set_name do
      expect(page).to have_content 'Paid'
      expect(page).not_to have_selector 'a.btn-success', text: 'Pay'
      expect(page).to have_selector 'a.btn-danger', text: 'Unpaid'
    end
    within 'li', text: order2.menu_set_name do
      expect(page).to have_content 'Pending'
      expect(page).to have_selector 'a.btn-success', text: 'Pay'
      expect(page).not_to have_selector 'a.btn-danger', text: 'Unpaid'
    end
  end
end
