require 'rails_helper'

feature "Update menu set" do
  scenario 'can change menu set attributes' do
    create :manager_example_com
    menu_set = create :menu_set, name: '1st menu set',
      available_on: 2.days.from_now

    sign_in_as 'manager@example.com'
    visit menu_sets_path
    within 'li', text: '1st menu set' do
      click_link 'Edit'
    end
    within "#edit_menu_set_#{menu_set.id}" do
      fill_in 'menu_set_name', with: 'Diet menu set'
      fill_in 'menu_set_details', with: 'Tea & Apple'
      click_button 'Update'
    end

    expect(page).to have_content 'Menu Set has been updated successfully'
    expect(page).to have_selector 'li', text: 'Diet menu set'
    expect(page).not_to have_selector 'li', text: '1st menu set'
  end
end
