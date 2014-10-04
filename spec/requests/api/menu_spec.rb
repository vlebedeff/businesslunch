require 'rails_helper'

RSpec.describe 'Menu API', type: :request do
  let!(:user) { create :user }
  let!(:access_token) do
    create :doorkeeper_access_token, resource_owner_id: user.id
  end

  describe 'GET /api/menus.json' do
    let!(:menu_set1) { create :menu_set, details: 'Soup' }
    let!(:menu_set2) { create :menu_set, details: 'Salad' }
    let!(:menu_set3) { create :menu_set, details: 'Salad', available_on: 1.day.ago }

    def do_request
      get "/api/menus.json?access_token=#{access_token.token}"
    end

    context 'when there is available menu sets' do
      before { do_request }

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

    context 'when orders is frozen' do
      before do
        Freeze.create
        do_request
      end

      it "responds with empty set" do
        expect(json).to eq([])
      end
    end
  end
end
