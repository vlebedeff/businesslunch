require 'rails_helper'

feature 'Welcome page' do
  context "when user didn't made orders for today" do
    scenario 'sees welcome title and button' do
      visit root_path

      expect(page).to have_content 'Got hungry?'
      expect(page).to have_selector 'a', text: 'Order now!'
    end
  end

  context 'when user has made order' do
    scenario "sees order's details" do
      user = create :user_example_com
      menu_set = create :menu_set, name: '1st menu set',
        details: 'Steak, Potato and Tea'
      create :order, user: user, menu_set: menu_set

      sign_in_as 'user@example.com'
      visit root_path

      expect(page).to have_content '1st menu set'
      expect(page).to have_content 'Steak, Potato and Tea'
      expect(page).to have_selector 'a', text: 'Make another order'
      expect(page).not_to have_selector 'a', text: 'Order now!'
    end
  end
end
