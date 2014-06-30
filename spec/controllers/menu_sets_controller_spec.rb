require 'rails_helper'

RSpec.describe MenuSetsController, type: :controller do
  before { sign_in_manager }

  describe 'GET #index' do
    before do
      allow(MenuSet).to receive(:order)
      get :index
    end

    it { expect(MenuSet).to have_received :order }
    it { is_expected.to respond_with :success }
    it { is_expected.to render_template :index }
  end
end
