require 'rails_helper'

feature 'Join Group' do
  context 'when user not in the group' do
    scenario 'user can join group' do
      create :user_example_com
      group = create :group, name: 'Head Office Group'

      sign_in_as 'user@example.com'
      visit groups_path
      within "#group_#{group.id}" do
        click_link 'Join'
      end

      expect(page).to have_content 'You have joined "Head Office Group" group'
      visit groups_path
      within "#group_#{group.id}" do
        expect(page).not_to have_selector 'a', text: 'Join'
      end
    end
  end
end
