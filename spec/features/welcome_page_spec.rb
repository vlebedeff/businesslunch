require 'rails_helper'

feature 'Welcome page' do
  scenario 'can visit welcome page' do
    visit root_path

    expect(page).to have_content 'Got hungry?'
    expect(page).to have_selector 'a', text: 'Order now!'
  end
end
