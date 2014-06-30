require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  before { sign_in_manager }

  describe 'GET #index' do
    before do
      allow(Dashboard).to receive :new
      get :index
    end

    it { expect(Dashboard).to have_received :new }
    it { is_expected.to respond_with :success }
    it { is_expected.to render_template :index }
  end
end
