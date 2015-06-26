require 'rails_helper'

RSpec.describe Dashboard, type: :model do

  describe '#current_counters' do
    let!(:user) { create :user, :groupped }
    let!(:menu_set1) { create :menu_set, details: 'Menu Set 1' }
    let!(:menu_set2) { create :menu_set, details: 'Menu Set 2' }
    let!(:order1) do
      create :order, menu_set: menu_set1, group: user.current_group
    end
    let!(:order2) do
      create :order, menu_set: menu_set1, group: user.current_group
    end
    let!(:order3) do
      create :order, menu_set: menu_set2, group: user.current_group
    end
    let!(:order4) do
      create :order, menu_set: menu_set2, group: user.current_group,
                     created_at: 1.day.ago
    end
    let!(:order_from_different_group) do
      create :order, menu_set: menu_set2
    end

    subject { Dashboard.new(user).current_counters }

    it "calculates today counters" do
      is_expected.to eq({
        menu_set1.name => OpenStruct.new(count: 2, details: menu_set1.details),
        menu_set2.name => OpenStruct.new(count: 1, details: menu_set2.details),
        'Total' => OpenStruct.new(count: 3)
      })
    end
  end
end
