require 'rails_helper'

RSpec.describe Api::MenusController, type: :controller do
  describe 'GET #index' do
    before do
      allow(MenuSet).to receive(:available)
      get :index, format: :json
    end

    it { expect(MenuSet).to have_received :available }
    it { is_expected.to respond_with :success }
    it { is_expected.to render_template :index }
  end
end
