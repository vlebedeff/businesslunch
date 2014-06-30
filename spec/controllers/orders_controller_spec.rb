require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:order) { mock_model Order, id: 1, menu_set_name: '1st menu set' }
  let(:attrs) do
    {
      'menu_set_id' => '1'
    }
  end
  let!(:user) { sign_in_manager }

  before do
    allow(user).to receive(:orders).and_return Order
  end

  describe 'GET #index' do
    before { get :index }
    it { expect(user).to have_received :orders }
    it { is_expected.to respond_with :success }
    it { is_expected.to render_template :index }
  end

  describe 'GET #new' do
    before do
      allow(Order).to receive(:new)
    end

    context 'when orders is frozen' do
      before do
        allow(Freeze).to receive(:frozen?).and_return true
        get :new
      end

      it { expect(Order).not_to have_received :new }
      it { is_expected.to redirect_to orders_path }
      it { is_expected.to set_the_flash[:alert] }
    end

    context 'when orders is not frozen' do
      before do
        allow(Freeze).to receive(:frozen?).and_return false
        get :new
      end

      it { expect(Order).to have_received :new }
      it { is_expected.to render_template :new }
      it { is_expected.to respond_with :success }
    end
  end

  describe 'POST #create' do
    before do
      allow(Order).to receive(:new).with(attrs).and_return order
    end

    context 'with valid attributes' do
      before do
        allow(order).to receive(:save).and_return true
        post :create, order: attrs
      end

      it { expect(user).to have_received :orders }
      it { expect(Order).to have_received :new }
      it { expect(order).to have_received :save }
      it { is_expected.to redirect_to orders_path }
      it { is_expected.to set_the_flash[:notice] }
    end

    context 'with invalid attributes' do
      before do
        allow(order).to receive(:save).and_return false
        post :create, order: attrs
      end

      it { expect(user).to have_received :orders }
      it { expect(Order).to have_received :new }
      it { expect(order).to have_received :save }
      it { is_expected.to render_template :new }
    end
  end

  describe 'PATCH #pay' do
    before do
      allow(Order).to receive(:find).with('1').and_return order
      allow(order).to receive(:pay!)
      patch :pay, id: order.id
    end

    it { expect(Order).to have_received :find }
    it { expect(order).to have_received :pay! }
    it { is_expected.to redirect_to dashboard_path }
  end

  describe 'DELETE #destroy' do
    before do
      allow(Order).to receive(:find).with('1').and_return order
      allow(order).to receive(:destroy)
      delete :destroy, id: order.id
    end

    it { expect(Order).to have_received :find }
    it { expect(order).to have_received :destroy }
    it { is_expected.to redirect_to dashboard_path }
  end
end
