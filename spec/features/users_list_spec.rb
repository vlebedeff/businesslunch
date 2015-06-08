require 'rails_helper'

feature 'Users List' do
  scenario 'manager can view list of all users' do
    create :manager_example_com
    create :user, email: 'user@example.com', balance: 100

    sign_in_as 'manager@example.com'
    visit dashboard_path
    click_link 'Users'

    expect(page).to have_selector 'tr', text: 'manager@example.com 0'
    expect(page).to have_selector 'tr', text: 'user@example.com 100'
  end
end
