require 'rails_helper'

feature 'Unfreeze orders' do
  context 'when orders are frozen' do
    scenario 'can unfroze them' do
      create :manager_example_com, :groupped
      create :freeze

      sign_in_as 'manager@example.com'
      visit dashboard_path
      click_link 'Unfreeze Orders'

      expect(page).to have_content 'Orders are available again.'
      expect(page).to have_selector 'a', text: 'Freeze Orders'
      expect(page).not_to have_selector 'a', text: 'Unfreeze Orders'
    end
  end
end
