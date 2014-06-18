require 'rails_helper'

feature 'Dashboard' do
  scenario "be able to visit dashboard page" do
    create :user_example_com

    sign_in_as 'user@example.com'
    visit root_path

    expect(page).to have_content 'Dashboard'
  end

  scenario 'unauthorized user redirecting to sign in page' do
    visit root_path

    expect(current_path).to eq new_user_session_path
  end
end
