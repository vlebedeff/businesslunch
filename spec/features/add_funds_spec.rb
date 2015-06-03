require 'rails_helper'

feature 'Add funds' do
  scenario 'can add funds to user account' do
    create :manager_example_com
    user = create :user, email: 'user-name@example.com', amount: 35

    sign_in_as 'manager@example.com'
    visit users_path
    within 'tr', text: 'user-name@example.com' do
      click_link 'Update Balance'
    end
    within "#edit_balance" do
      fill_in 'balance_amount', with: 100
      click_button 'Update Balance'
    end

    expect(page).to have_content successful_message
    user.reload
    expect(user.amount).to eq 135
  end
end

def successful_message
  "user-name's balance has been credited with 100 lei"
end
