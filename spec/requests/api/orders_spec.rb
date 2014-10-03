require 'rails_helper'

RSpec.describe 'Orders API', type: :request do
  let!(:user) { create :user }
  let!(:access_token) do
    create :doorkeeper_access_token, resource_owner_id: user.id
  end

  describe 'POST /api/orders.json' do
    let!(:menu_set1) { create :menu_set }

    context 'when valid attributes' do
      subject do
        post "/api/orders.json",
          access_token: access_token.token,
          order: { menu_set_id: menu_set1.id }
      end

      it "creates new order" do
        expect { subject }.to change(Order, :count).by 1
      end
    end

    context 'when invalid attributes' do
      let!(:menu_set2) { create :menu_set, available_on: 1.day.ago }
      subject do
        post "/api/orders.json",
          access_token: access_token.token,
          order: { menu_set_id: menu_set2.id }
      end

      it "do not creates new order" do
        expect { subject }.not_to change(Order, :count)
      end

      it "responds with errors" do
        subject
        expect(json).to eq({ "menu_set" => ["can't be blank"] })
      end
    end
  end
end
