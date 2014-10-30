require 'rails_helper'

describe 'Tokens API' do

  describe 'Authorization' do
    before do
      @app = create :doorkeeper_application
      @attributes = {
        grant_type: 'password',
        client_id: @app.uid,
        client_secret: @app.secret,
        email: 'email@example.com',
        password: 'password',
        parse_object_id: '1234'
      }
    end

    context 'with valid credentials' do
      let!(:user) { create :user, email: 'email@example.com' }

      before { post "/api/token.json", @attributes }

      it "responds with :success" do
        expect(response.status).to eq 200
      end

      it "responds with token" do
        expect(json).to be_present
      end

      it "links user and installation" do
        expect(user.parse_installations.count).to eq 1
      end
    end

    context 'with invalid credentials' do
      it 'responds with :unauthorized' do
        post "/api/token.json", @attributes

        expect(response.code).to eq "401"
      end
    end
  end
end
