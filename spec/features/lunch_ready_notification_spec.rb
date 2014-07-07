require 'sidekiq/testing'
require 'rails_helper'

Sidekiq::Testing.inline!

feature 'Lunch is Ready notification' do
  scenario 'can send Lunch readyness notification' do
    reset_email
    create :manager_example_com
    user1 = create :user
    user2 = create :user
    order = create :order, user: user1
    user3 = create :user
    order = create :order, user: user3

    sign_in_as 'manager@example.com'
    visit dashboard_path
    click_link 'Send notification'

    expect(page).to have_content 'Notification has been sent.'
    expect(last_email.subject).to eq 'Neam-neam is here'
    expect(total_emails_count).to eq 2
  end
end
