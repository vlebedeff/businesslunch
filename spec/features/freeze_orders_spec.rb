require 'rails_helper'

feature 'Freeze orders' do
  scenario 'can freeze orders for today' do
    create :manager_example_com, :groupped

    sign_in_as 'manager@example.com'
    visit dashboard_path
    click_link 'Freeze Orders'

    expect(page).to have_content 'Orders are frozen for today.'
    expect(page).not_to have_link 'Freeze Orders'
  end
end
