require 'rails_helper'

feature 'Delete users' do
  context "when user's balance is zero" do
    scenario 'admin can delete user' do
      create :admin_example_com
      sign_in_as 'admin@example.com'
      user = create :user, email: 'user@example.com'
      visit users_path

      find("#delete_user_#{user.id}").click

      expect(current_path).to eq users_path
      expect(page).not_to have_selector "#delete_user_#{user.id}"
      expect(User.where(id: user.id)).not_to be_exists
    end
  end

  context "when user's balance is positive" do
    scenario 'no one can delete user' do
      create :admin_example_com
      sign_in_as 'admin@example.com'
      user = create :user, email: 'user@example.com', balance: 1
      visit users_path

      expect(page).not_to have_selector "#delete_user_#{user.id}"
    end
  end
end
