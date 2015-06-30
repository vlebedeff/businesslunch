require 'rails_helper'

feature 'Users List' do
  scenario 'manager can view list of all users' do
    group = create :group

    manager = create :manager_example_com, current_group: group
    create :user_group, group: group, user: manager, balance: 20

    user = create :user, email: 'user@example.com', current_group: group
    create :user_group, group: group, user: user, balance: 100

    sign_in_as 'manager@example.com'
    visit dashboard_path
    click_link 'Users'

    expect(page).to have_selector 'tr', text: 'manager@example.com 20'
    expect(page).to have_selector 'tr', text: 'user@example.com 100'
    expect(page).to have_selector 'th', text: 'Balance summary: 120.0 MDL'
  end
end
