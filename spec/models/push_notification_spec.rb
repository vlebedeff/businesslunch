require 'rails_helper'

RSpec.describe PushNotification, type: :model do
  describe '#lunch_ready' do
    let(:push) { Parse::Push.new({}, "") }
    let(:query) { Parse::Query.new(nil).value_in("installationId", []) }
    let!(:order) { create :order }
    let!(:installation) { create :parse_installation, user: order.user }
    let(:message_attrs) do
      {
        alert: "Neam-neam is here",
        sound: 'Default'
      }
    end

    before do
      allow(Parse::Push).to receive(:new).
        with(message_attrs, "").
        and_return push
      allow(Parse::Query).to receive(:new).and_return query
      allow(query).to receive(:value_in).
        with("objectId", [installation.parse_object_id]).
        and_return query
      allow(push).to receive :save
    end

    it "sends Push Notification" do
      PushNotification.lunch_ready(order.user)
      expect(push).to have_received :save
    end
  end
end
