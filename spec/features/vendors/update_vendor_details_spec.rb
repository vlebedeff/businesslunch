require 'rails_helper'

feature 'Update Vendor' do
  scenario 'manager can update vendor details' do
    create :admin_example_com
    vendor = create :vendor, name: 'Bistro'

    sign_in_as 'admin@example.com'
    visit vendors_path
    within 'tr', text: 'Bistro' do
      click_link 'Edit'
    end
    within "#edit_vendor_#{vendor.id}" do
      fill_in 'vendor_name', with: "Andy's Pizza"
      click_button 'Update Vendor'
    end

    expect(page).to have_content 'Vendor has been updated successfully'
    expect(page).to have_selector 'tr', text: "Andy's Pizza"
    expect(page).not_to have_selector 'tr', text: 'Bistro'
  end
end
