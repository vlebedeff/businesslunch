require 'rails_helper'

feature 'Today Menu' do
  scenario 'can create menu for today' do
    create :manager_example_com, :groupped

    sign_in_as 'manager@example.com'
    visit dashboard_path
    click_link 'New Menu'
    within '#new_menu' do
      fill_in 'menu_set_0_name', with: '1st menu set'
      fill_in 'menu_set_1_name', with: '2nd menu set'
      fill_in 'menu_set_2_name', with: 'Diet menu set'
      click_button 'Create Menu'
    end

    expect(page).to have_content '1st menu set'
    expect(page).to have_content '2nd menu set'
    expect(page).to have_content 'Diet menu set'
  end
end
