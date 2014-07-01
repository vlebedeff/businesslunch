require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  before { sign_in_manager }

  describe 'GET #new' do
    before do
      get :new
    end

    it { is_expected.to render_template :new }
    it { is_expected.to respond_with :success }
  end

  describe 'POST #create' do
    let(:attrs) do
      {
        "begin_on(1i)" => '2014',
        "begin_on(2i)" => 'July',
        "begin_on(3i)" => '1',
        "end_on(1i)" => '2014',
        "end_on(2i)" => 'July',
        "end_on(3i)" => '2'
      }
    end
    before do
      allow(Report).to receive(:new).with(
        Date.parse('2014-July-1'),
        Date.parse('2014-July-2')
      )
      post :create, report: attrs
    end

    it { expect(Report).to have_received :new }
    it { is_expected.to render_template :show }
    it { is_expected.to respond_with :success }
  end
end
