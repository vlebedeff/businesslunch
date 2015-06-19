require 'rails_helper'

feature 'List of vendors' do
  scenario 'manager can see list of vendors' do
    create :manager_example_com

    sign_in_as 'manager@example.com'
    visit vendors_path

    expect(page).to have_selector 'h1', text: 'Vendors'
  end
end
