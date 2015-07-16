require 'rails_helper'

feature 'Change current group' do
  scenario 'user can change his current group' do
    secondary = create :group, name: 'Secondary group'
    user = create :user_example_com, :groupped, group: secondary
    primary = create :group, name: 'Primary group'
    create :user_group, user: user, group: primary

    sign_in_as 'user@example.com'
    visit groups_path
    click_set_as_current_link_within_group primary

    expect(page).to have_content 'Your current group now is "Primary group"'
    visit groups_path
    expect_user_current_group_has_updated user, primary
    expect_not_to_see_set_as_current_link_within_group primary
    expect_to_see_set_as_current_link_within_group secondary
    expect_to_see_current_label_for_group primary
  end
end

def click_set_as_current_link_within_group(group)
  within "#group_#{group.id}" do
    click_link 'Make current'
  end
end

def expect_user_current_group_has_updated(user, current_group)
  user.reload
  expect(user.current_group).to eq current_group
end

def expect_not_to_see_set_as_current_link_within_group(group)
  within "#group_#{group.id}" do
    expect(page).not_to have_selector 'a', text: 'Make current'
  end
end

def expect_to_see_set_as_current_link_within_group(group)
  within "#group_#{group.id}" do
    expect(page).to have_selector 'a', text: 'Make current'
  end
end

def expect_to_see_current_label_for_group(group)
  within "#group_#{group.id}" do
    expect(page).to have_selector 'span', text: 'Current'
  end
end
