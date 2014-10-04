require 'rails_helper'

RSpec.describe Api::MenusController, type: :controller do
  let!(:access_token) { sign_in_api_user }

  describe 'GET #index' do
    before do
      allow(MenuQuery).to receive(:if_not_frozen)
      get :index, format: :json, access_token: access_token.token
    end

    it { expect(MenuQuery).to have_received :if_not_frozen }
    it { is_expected.to respond_with :success }
    it { is_expected.to render_template :index }
  end
end
