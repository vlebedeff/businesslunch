require 'rails_helper'

RSpec.describe 'Menu API', type: :request do
  describe 'GET /api/menus.json' do
    let!(:menu_set1) { create :menu_set, details: 'Soup' }
    let!(:menu_set2) { create :menu_set, details: 'Salad' }
    let!(:menu_set3) { create :menu_set, details: 'Salad', available_on: 1.day.ago }

    before do
      get "/api/menus.json"
    end

    it "responds with current menu" do
      expect(json).to eq([
        {
          "id" => menu_set1.id,
          "name" => menu_set1.name,
          "details" => menu_set1.details
        },
        {
          "id" => menu_set2.id,
          "name" => menu_set2.name,
          "details" => menu_set2.details
        },
      ])
    end
  end
end
