require 'rails_helper'

feature 'Lunch is Ready notification' do
  scenario 'can send Lunch readyness notification' do
    group = create :group
    create :manager_example_com, :groupped, group: group
    user1 = create :user, :groupped, group: group
    user2 = create :user, :groupped, group: group
    order = create :order, user: user1
    user3 = create :user, :groupped, group: group
    order = create :order, user: user3
    reset_email

    sign_in_as 'manager@example.com'
    visit dashboard_path

    Sidekiq::Testing.inline! do
      click_link 'Send notification'
    end

    expect(page).to have_content 'Notification has been sent.'
    expect(last_email.subject).to eq 'Neam-neam is here'
    expect(total_emails_count).to eq 2
  end
end
