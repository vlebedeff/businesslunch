require 'rails_helper'

feature 'Dashboard' do
  scenario "be able to visit dashboard page" do
    create :manager_example_com

    sign_in_as 'manager@example.com'
    visit dashboard_path

    expect(page).to have_content 'Dashboard'
  end
end
