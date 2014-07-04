require 'rails_helper'

class Array
  alias :find_each :each
end

RSpec.describe LunchesController, type: :controller do
  before { sign_in_manager }
  let(:order) { double user_id: 1, menu_set_id: 2 }

  describe "POST #ready" do
    let(:mailer) { double }
    before do
      allow(Order).to receive(:today).and_return [order]
      allow(NotificationWorker).to receive(:perform_async).with(1, 2)
      allow(mailer).to receive(:deliver)
      post :ready
    end

    it { expect(Order).to have_received :today }
    it { expect(NotificationWorker).to have_received :perform_async }
    it { is_expected.to redirect_to dashboard_path }
    it { is_expected.to set_the_flash[:notice] }
  end
end
