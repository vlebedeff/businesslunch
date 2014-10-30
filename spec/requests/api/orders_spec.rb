require 'rails_helper'

RSpec.describe 'Orders API', type: :request do
  let!(:user) { create :user }
  let!(:access_token) do
    create :doorkeeper_access_token, resource_owner_id: user.id
  end

  describe 'GET /api/orders.json' do
    let!(:yesterday_order) { create :order, user: user, created_on: 1.day.ago }
    let!(:order) { create :order, user: user }
    let!(:other_order) { create :order }

    before do
      get "/api/orders.json?access_token=#{access_token.token}"
    end

    it "responds with orders list" do
      expect(json).to eq([
        {
          "id" => order.id,
          "state"  => order.state,
          "created_on" => order.created_on.to_s,
          "menu_set" => {
            "name" => order.menu_set.name,
            "details" => order.menu_set.details
          }
        },
        {
          "id" => yesterday_order.id,
          "state"  => yesterday_order.state,
          "created_on" => yesterday_order.created_on.to_s,
          "menu_set" => {
            "name" => yesterday_order.menu_set.name,
            "details" => yesterday_order.menu_set.details
          }
        }
      ])
    end
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

    context 'when orders are frozen' do
      subject do
        Freeze.create
        post "/api/orders.json",
          access_token: access_token.token,
          order: { menu_set_id: menu_set1.id }
      end

      it "responds with errors" do
        subject
        expect(json).to eq({ "orders" => ["are frozen"] })
      end
    end
  end

  describe 'DELETE /api/orders.json' do
    let!(:order) { create :order, user: user }

    subject do
      delete "/api/orders/#{order.id}.json?access_token=#{access_token.token}"
    end

    it "removes the order" do
      expect { subject }.to change(Order, :count).by -1
    end
  end
end
