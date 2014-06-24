require 'rails_helper'

RSpec.describe MenusController, type: :controller do
  let!(:manager) { create :user, :manager }
  let(:menu_attrs) do
    {
      "available_on(1i)" => "2014",
      "available_on(2i)" => "6",
      "available_on(3i)" => "24",
      "menu_set"=>{
        "0" => { "name"=>"1st menu set" },
        "1" => { "name"=>"2nd menu set" },
        "2" => { "name"=>"Diet menu" } } }
  end
  let(:menu) { double }

  before { sign_in manager }

  describe 'GET #new' do
    before do
      allow(Menu).to receive(:new).and_return menu
      get :new
    end

    it { expect(Menu).to have_received :new }
    it { is_expected.to respond_with :success }
    it { is_expected.to render_template :new }
  end

  describe 'POST #create' do
    before do
      allow(Menu).to receive(:from_params).with(menu_attrs).and_return menu
    end

    context 'when valid attributes' do
      before do
        allow(menu).to receive(:save).and_return true
        post :create, menu: menu_attrs
      end

      it { expect(Menu).to have_received :from_params }
      it { expect(menu).to have_received :save }
      it { is_expected.to redirect_to menu_sets_path }
    end

    context 'when invalid attributes' do
      before do
        allow(menu).to receive(:save).and_return false
        post :create, menu: menu_attrs
      end

      it { expect(Menu).to have_received :from_params }
      it { expect(menu).to have_received :save }
      it { is_expected.to render_template :new }
    end
  end
end
