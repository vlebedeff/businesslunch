require 'rails_helper'

RSpec.describe Api::OrdersController, type: :controller do
  let!(:user) { mock_model User }
  let!(:access_token) { sign_in_api_user }
  let!(:menu_set) { mock_model MenuSet, id: 3 }
  let!(:order) { mock_model Order }

  before do
    allow(controller).to receive(:current_resource_owner).and_return user
  end

  describe 'POST #create' do
    before do
      allow(MenuSet).to receive(:available).and_return MenuSet
      allow(MenuSet).to receive(:find_by).
        with(id: "3").and_return menu_set
      allow(Order).to receive(:new).
        with(user: user, menu_set: menu_set).
        and_return order
    end

    context 'with valid attributes' do
      before do
        allow(order).to receive(:save).and_return true
        post :create, access_token: access_token.token,
          order: { menu_set_id: 3 }
      end

      it { expect(order).to have_received :save }
      it { is_expected.to respond_with :created }
    end

    context 'with invalid attributes' do
      before do
        allow(order).to receive(:save).and_return false
        post :create, access_token: access_token.token,
          order: { menu_set_id: 3 }
      end

      it { expect(order).to have_received :save }
      it { is_expected.to respond_with :unprocessable_entity }
    end
  end
end
