require 'rails_helper'

RSpec.describe MenuSetsController, type: :controller do
  let(:menu_set) { mock_model MenuSet, id: 1 }

  before do
    sign_in_manager
    allow(MenuSet).to receive(:find).with('1').and_return menu_set
  end

  describe 'GET #index' do
    before do
      allow(MenuSet).to receive(:order)
      get :index
    end

    it { expect(MenuSet).to have_received :order }
    it { is_expected.to respond_with :success }
    it { is_expected.to render_template :index }
  end

  describe 'GET #edit' do
    before { get :edit, id: menu_set.id }
    it { expect(MenuSet).to have_received :find }
    it { is_expected.to render_template :edit }
    it { is_expected.to respond_with :success }
  end

  describe 'PATCH #update' do
    let(:attrs) do
      {
        "name" => "Diet menu set",
        "details" => "Apple & Tea"
      }
    end

    context 'when valid attributes' do
      before do
        allow(menu_set).to receive(:update_attributes).with(attrs).
          and_return true
        patch :update, id: menu_set.id, menu_set: attrs
      end

      it { expect(menu_set).to have_received :update_attributes }
      it { is_expected.to redirect_to menu_sets_path }
      it { is_expected.to set_the_flash[:notice] }
    end

    context 'when invalid attributes' do
      before do
        allow(menu_set).to receive(:update_attributes).with(attrs).
          and_return false
        patch :update, id: menu_set.id, menu_set: attrs
      end

      it { expect(menu_set).to have_received :update_attributes }
      it { is_expected.to render_template :edit }
    end
  end
end
