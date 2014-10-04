require 'rails_helper'

RSpec.describe MenuQuery, type: :model do
  describe '#if_not_frozen' do
    let!(:menu_set) { create :menu_set }

    context 'when orders is not frozen' do
      it "returns available menu sets" do
        expect(MenuQuery.new.if_not_frozen).to eq [menu_set]
      end
    end

    context 'when orders is frozen' do
      it "returns empty set" do
        Freeze.create

        expect(MenuQuery.new.if_not_frozen).to eq []
      end
    end
  end
end
