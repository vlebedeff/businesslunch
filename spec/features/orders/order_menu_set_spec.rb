require 'rails_helper'

feature 'Ordering Menu Set' do
  context 'when there is menu sets for today' do
    scenario 'can make an order' do
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

  context 'when there is no menu sets' do
    scenario 'cannot make an order' do
      create :user_example_com

      sign_in_as 'user@example.com'
      visit new_order_path

      expect(page).to have_content 'There is no menu sets for today'
    end
  end
end
