require 'rails_helper'

feature 'Create Vendor' do
  scenario 'manager can create vendor with valid name' do
    create :admin_example_com

    sign_in_as 'admin@example.com'
    visit vendors_path
    click_link 'Add Vendor'
    within '#new_vendor' do
      fill_in 'vendor_name', with: 'Bistro'
      click_button 'Create Vendor'
    end

    expect(page).to have_content 'Vendor has been created successfully'
    expect(page).to have_selector 'tr', text: 'Bistro'
  end
end
