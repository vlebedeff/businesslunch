require 'rails_helper'

feature 'Dashboard' do
  scenario "be able to visit dashboard page" do
    visit root_path

    expect(page).to have_content 'Dashboard'
  end
end
