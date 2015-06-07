require 'rails_helper'

feature 'Activity Feed' do
  scenario 'manager can visit activity feed page' do
    manager = create :manager_example_com, email: 'john.doe@example.com'
    user = create :user, email: 'john.wayne@example.com'
    create :activity, user: manager, subject: user,
                      action: 'balance_update',
                      data: '100'
    create :activity, user: user, subject: create(:order, user: user),
                      action: 'payment',
                      data: '35'

    sign_in_as 'john.doe@example.com'
    within '.navbar' do
      click_link 'Activity'
    end

    expect(page).to have_selector 'h1', text: 'Activity feed'
    expect(page).to have_content activity_balance_record
    expect(page).to have_content payment_activity_record
  end

  scenario 'regular user cannot see activity feed' do
    create :user_example_com

    sign_in_as 'user@example.com'
    visit activity_path

    expect(page).to have_content "You are not authorized to access this page"
  end
end

def activity_balance_record
  'John Doe have updated balance of John Wayne for 100 Lei'
end

def payment_activity_record
  'John Wayne have paid for the lunch 35 Lei'
end
