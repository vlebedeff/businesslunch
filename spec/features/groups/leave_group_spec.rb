require 'rails_helper'

feature 'Leave group' do
  context 'when user is in group' do
    scenario 'he can leave that group' do
      group = create :group, name: 'Head Office'
      user = create :user_example_com, :groupped, group: group

      sign_in_as 'user@example.com'
      visit groups_path
      within "#group_#{group.id}" do
        click_link 'Leave'
      end

      expect(page).to have_content 'You need to join group to start using all available features'
      visit groups_path
      within "#group_#{group.id}" do
        expect(page).not_to have_selector 'a', text: 'Leave'
      end
    end
  end
end
