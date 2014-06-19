require 'rails_helper'

feature 'Orders list' do
  scenario 'user be able to see his orders' do
    create :user_example_com

    sign_in_as 'user@example.com'

    expect(current_path).to eq orders_path
    expect(page).to have_content 'Orders'
  end
end
