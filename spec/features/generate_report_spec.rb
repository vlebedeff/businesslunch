require 'rails_helper'

feature "Generate Report" do
  scenario 'can generate report by date range' do
    create :manager_example_com
    create :order, created_at: 1.day.ago
    create :order, created_at: 2.days.ago
    create :order, created_at: Date.today

    begin_on = 3.days.ago.to_date
    end_on = Date.today

    sign_in_as 'manager@example.com'
    visit dashboard_path
    click_link 'Report'
    select begin_on.strftime("%Y"), from: 'report_begin_on_1i'
    select begin_on.strftime("%B"), from: 'report_begin_on_2i'
    select begin_on.strftime("%-d"), from: 'report_begin_on_3i'
    select end_on.strftime("%Y"), from: 'report_end_on_1i'
    select end_on.strftime("%B"), from: 'report_end_on_2i'
    select end_on.strftime("%-d"), from: 'report_end_on_3i'

    click_button 'Generate'
    expect(page).to have_content 'Total: 3'
  end
end
