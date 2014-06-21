require 'rails_helper'

feature 'Ordering Menu Set' do
  scenario 'can order menu set' do
    create :user_example_com
    create :menu_set, name: '1st menu set'

    sign_in_as 'user@example.com'

    click_link 'Order Now!'
    within '#new_order' do
      choose '1st menu set'
      click_button 'Order'
    end

    expect(page).to have_content "You have ordered \"1st menu set\""
  end
end
