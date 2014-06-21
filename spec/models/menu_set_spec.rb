require 'rails_helper'

RSpec.describe MenuSet, type: :model do
  it 'has a valid factory' do
    expect(create :menu_set).to be_valid
  end

  describe '.validations' do
    context 'when valid' do
      subject { create :menu_set }
      it { should validate_presence_of :name }
      it { should validate_uniqueness_of(:name).scoped_to :available_on }
      it { should validate_presence_of :available_on }
    end
  end

  describe '.available' do
    let!(:menu_set1) { create :menu_set, available_on: 1.day.ago.to_date }
    let!(:menu_set2) { create :menu_set }

    it "fetches available today menu sets" do
      expect(MenuSet.available.to_a).to eq [menu_set2]
    end
  end
end
