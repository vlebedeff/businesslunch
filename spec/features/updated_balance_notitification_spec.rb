require 'rails_helper'

feature 'Updated balance notification' do
  scenario 'user receives message when his balance has been updated' do
    user = create :user
    create :manager_example_com

    sign_in_as 'manager@example.com'
    visit edit_user_balance_path(user)
    fill_in 'Amount', with: 100

    Sidekiq::Testing.inline! do
      reset_email
      click_button 'Update Balance'
    end

    expect(last_email.subject).to eq 'Your balance has been updated'
    expect(last_email.to).to eq [user.email]
  end
end
