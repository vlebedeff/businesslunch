require 'rails_helper'

feature 'Groups list' do
  scenario 'users can see list of existed groups' do
    create :user_example_com
    group = create :group, name: 'Head Office Group #1'

    sign_in_as 'user@example.com'
    visit groups_path

    within "#group_#{group.id}" do
      expect(page).to have_content 'Head Office Group #1'
    end
  end
end
