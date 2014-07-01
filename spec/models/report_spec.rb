require 'rails_helper'

RSpec.describe Report do
  let!(:order1) { create :order, created_at: 1.day.ago }
  let!(:order2) { create :order, created_at: 2.days.ago }
  let!(:order3) { create :order, created_at: Date.today }
  let!(:order4) { create :order, created_at: 3.days.ago }
  let(:report) { Report.new(DateRange.new(2.days.ago.to_date, Date.today)) }

  describe '#total' do
    subject { report.total }
    it { is_expected.to eq 3 }
  end

  describe '#orders' do
    subject { report.orders.to_a }
    it "returns orders within range" do
      is_expected.to eq [order2, order1, order3]
    end
  end
end
