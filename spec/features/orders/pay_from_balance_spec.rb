require 'rails_helper'

feature 'Pay from Balance' do
  context 'when there is enough funds to pay for lunch' do
    given!(:user) { create :user_example_com, balance: 100 }
    given!(:order) { create :order, user: user }

    scenario 'user can pay from balance' do
      sign_in_as 'user@example.com'
      visit orders_path

      within "#order_#{order.id}" do
        click_link 'Pay from Balance'
      end

      expect_to_see_successfully_paid_result user, order
    end

    scenario 'user can pay from balance right after create new order' do
      sign_in_as 'user@example.com'
      visit orders_path

      within '.hints' do
        expect(page).to have_content "You have sufficient funds to pay for the order from your balance."
        expect(page).to have_content "Would you like to pay it now?"
        expect(page).to have_selector 'a.btn-success', text: 'Yes. Pay from my balance!'
      end

      click_link 'Yes. Pay from my balance!'

      expect_to_see_successfully_paid_result user, order
    end
  end
end

def expect_to_see_successfully_paid_result(user, order)
    expect(page).to have_content 'You have paid for order from your balance'
    user.reload
    expect(user.balance).to eq 65
    within "#order_#{order.id}" do
      expect(page).to have_selector 'span.label-success', text: 'Paid'
      expect(page).not_to have_selector 'a', text: 'Pay from Balance'
    end
end
