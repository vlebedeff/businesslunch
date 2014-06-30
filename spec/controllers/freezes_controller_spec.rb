require 'rails_helper'

RSpec.describe FreezesController, type: :controller do
  before { sign_in_manager }

  describe 'POST #create' do
    before do
      allow(Freeze).to receive :create
      post :create
    end

    it { expect(Freeze).to have_received :create }
    it { is_expected.to redirect_to dashboard_path }
    it { is_expected.to set_the_flash[:notice] }
  end

  describe 'DELETE #destroy' do
    before do
      allow(Freeze).to receive :unfreeze
      post :destroy
    end

    it { expect(Freeze).to have_received :unfreeze }
    it { is_expected.to redirect_to dashboard_path }
    it { is_expected.to set_the_flash[:notice] }
  end
end
