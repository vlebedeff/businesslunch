require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  let!(:user) { create :user, :manager }

  before { sign_in user }

  describe 'GET #index' do
    before { get :index }
    it { is_expected.to respond_with :success }
    it { is_expected.to render_template :index }
  end
end
