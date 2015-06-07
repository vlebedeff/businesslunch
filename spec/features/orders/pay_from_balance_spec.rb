require 'rails_helper'

feature 'Pay from Balance' do
  context 'when there is enough funds to pay for lunch' do
    given!(:user) { create :user_example_com, amount: 100 }
    given!(:order) { create :order, user: user }

    scenario 'user can pay from balance' do
      sign_in_as 'user@example.com'

      visit orders_path

      within "#order_#{order.id}" do
        click_link 'Pay from Balance'
      end

      expect(page).to have_content 'You have paid for order from your balance'
      user.reload
      expect(user.amount).to eq 65
      within "#order_#{order.id}" do
        expect(page).to have_selector 'span.label-success', text: 'Paid'
        expect(page).not_to have_selector 'a', text: 'Pay from Balance'
      end
    end
  end
end
