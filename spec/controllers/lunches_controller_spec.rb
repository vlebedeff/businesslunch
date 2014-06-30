require 'rails_helper'

RSpec.describe LunchesController, type: :controller do
  let!(:manager) { create :user, :manager }

  before { sign_in manager }

  describe "POST #ready" do
    let(:mailer) { double }
    before do
      allow(NotificationMailer).to receive(:lunch_ready).and_return mailer
      allow(mailer).to receive(:deliver)
      post :ready
    end

    it { expect(NotificationMailer).to have_received :lunch_ready }
    it { expect(mailer).to have_received :deliver }
    it { is_expected.to redirect_to dashboard_path }
    it { is_expected.to set_the_flash[:notice] }
  end
end
