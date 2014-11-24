require 'rails_helper'

RSpec.describe Api::OrdersController, type: :controller do
  let!(:order) { mock_model Order }
  let!(:user) { mock_model User, orders: [order] }
  let!(:access_token) { sign_in_api_user }
  let!(:menu_set) { mock_model MenuSet, id: 3 }

  before do
    allow(Freeze).to receive(:frozen?).and_return false
    allow(controller).to receive(:current_resource_owner).and_return user
  end

  describe 'GET #index' do
    let(:query) { double }
    before do
      allow(OrdersQuery).to receive(:new).with([order]).
        and_return query
      allow(query).to receive(:all).and_return Order
      allow(Order).to receive(:limit).with(10)
      get :index, format: :json, access_token: access_token.token
    end

    it { is_expected.to respond_with :success }
    it { is_expected.to render_template :index }
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

  describe 'DELETE #destroy' do
    before do
      allow(user).to receive(:orders).and_return Order
      allow(Order).to receive(:removable).and_return Order
      allow(Order).to receive(:find).and_return order
      allow(order).to receive(:destroy)

      delete :destroy, id: order.id, access_token: access_token.token
    end

    it { expect(user).to have_received :orders }
    it { expect(Order).to have_received :removable }
    it { expect(Order).to have_received :find }
    it { expect(order).to have_received :destroy }
    it { is_expected.to respond_with :no_content }
  end
end
