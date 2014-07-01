require 'rails_helper'

RSpec.describe Dashboard, type: :model do

  describe '#current_counters' do
    let!(:menu_set1) { create :menu_set }
    let!(:menu_set2) { create :menu_set }
    let!(:order1) { create :order, menu_set: menu_set1 }
    let!(:order2) { create :order, menu_set: menu_set1 }
    let!(:order3) { create :order, menu_set: menu_set2 }
    let!(:order4) { create :order, menu_set: menu_set2, created_at: 1.day.ago }

    subject { Dashboard.new.current_counters }

    it "calculates today counters" do
      is_expected.to eq({
        menu_set1.name => 2,
        menu_set2.name => 1,
        'Total' => 3
      })
    end
  end
end
