require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  let!(:user) { create :user, :manager }

  before do
    sign_in user
  end

  describe 'GET #index' do
    before do
      allow(Order).to receive(:includes).with(:menu_set, :user).
        and_return Order
      allow(Order).to receive(:order).with(:created_at)
      get :index
    end

    it { expect(Order).to have_received :includes }
    it { expect(Order).to have_received :order }
    it { is_expected.to respond_with :success }
    it { is_expected.to render_template :index }
  end
end
