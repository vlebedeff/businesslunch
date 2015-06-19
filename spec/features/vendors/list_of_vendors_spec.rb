require 'rails_helper'

feature 'List of vendors' do
  scenario 'admin can see list of vendors' do
    create :admin_example_com
    create :vendor, name: 'Bistro'

    sign_in_as 'admin@example.com'
    visit vendors_path

    expect(page).to have_selector 'h1', text: 'Vendors'
    expect(page).to have_selector 'tr', text: 'Bistro'
  end
end
