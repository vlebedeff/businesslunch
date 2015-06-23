require 'rails_helper'

feature 'Leave group' do
  context 'when user is in group' do
    scenario 'he can leave that group' do
      user = create :user_example_com
      group = create :group, name: 'Head Office'
      create :user_group, user: user, group: group

      sign_in_as 'user@example.com'
      visit groups_path
      within "#group_#{group.id}" do
        click_link 'Leave'
      end

      expect(page).to have_content 'You have left "Head Office" group'
      visit groups_path
      within "#group_#{group.id}" do
        expect(page).not_to have_selector 'a', text: 'Leave'
      end
    end
  end
end
