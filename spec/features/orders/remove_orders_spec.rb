require 'rails_helper'

feature 'Remove orders' do
  scenario 'can remove order from Dashboard' do
    create :manager_example_com
    user = create :user
    create :order, user: user

    sign_in_as 'manager@example.com'
    visit dashboard_path
    within 'li', text: user.email do
      click_link 'Delete'
    end

    expect(page).not_to have_content user.email
  end
end