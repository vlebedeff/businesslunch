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
      user = create :user_example_com, :groupped, balance: 103
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

  context 'when user signed in' do
    context 'when user is in the group' do
      scenario 'has access to welcome page' do
        user = create :user_example_com, :groupped

        sign_in_as 'user@example.com'
        visit root_path

        expect(page).to have_content 'Got hungry?'
        expect(page).to have_selector 'a', text: 'Order now!'
      end
    end

    context 'when user is not in the group' do
      scenario 'has access to welcome page' do
        user = create :user_example_com

        sign_in_as 'user@example.com'
        visit root_path

        expect(current_path).to eq groups_path
        expect(page).to have_content 'You need to join group to start using all available features'
      end
    end
  end
end
