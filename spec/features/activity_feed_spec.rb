require 'rails_helper'

feature 'Activity Feed' do
  scenario 'manager can visit activity feed page' do
    create :manager_example_com
    activity = create :activity, action: 'balance_update', data: '100'

    sign_in_as 'manager@example.com'
    within '.navbar' do
      click_link 'Activity'
    end

    expect(page).to have_selector 'h1', text: 'Activity feed'
    expect(page).to have_content activity_balance_record(activity)
  end

  scenario 'regular user cannot see activity feed' do
    create :user_example_com

    sign_in_as 'user@example.com'
    visit activity_path

    expect(page).to have_content "You are not authorized to access this page"
  end
end

def activity_balance_record(activity)
  %(#{activity.user.email} have updated balance of
     #{activity.subject.email} for #{activity.data} Lei)
end
