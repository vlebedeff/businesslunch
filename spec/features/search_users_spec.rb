require 'rails_helper'

feature 'Search users' do
  scenario 'manager can search through users' do
    group = create :group
    create :manager_example_com, :groupped, group: group
    create :user, :groupped, email: 'john.doe@example.com', group: group
    create :user, :groupped, email: 'bruce.wayne@example.com', group: group

    sign_in_as 'manager@example.com'
    visit users_path

    expect(page).to have_selector 'tr', text: 'john.doe@example.com'
    expect(page).to have_selector 'tr', text: 'bruce.wayne@example.com'

    fill_in 'query', with: 'Bruce'
    click_button 'Search!'

    expect(page).not_to have_selector 'tr', text: 'john.doe@example.com'
    expect(page).to have_selector 'tr', text: 'bruce.wayne@example.com'
  end
end
