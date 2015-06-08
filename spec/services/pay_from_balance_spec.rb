require 'rails_helper'

RSpec.describe PayFromBalance, type: :model do
  describe '.call' do
    subject { PayFromBalance.call order, user }

    let!(:user) { create :user, balance: 100 }
    let!(:order) { create :order, user: user }

    context 'when user can pay' do
      before do
        allow(user).to receive(:can_pay_for?).with(order).and_return true
      end

      it "changes order's state" do
        expect { subject }.to change { order.state }.to 'paid'
      end

      it "changes user's balance" do
        expect { subject }.to change { user.balance }.to 65
      end

      it "creates payment activity" do
        expect { subject }.to change(Activity, :count).by 1
      end

      it { is_expected.to be_truthy }
    end

    context 'when user cannot pay' do
      before do
        allow(user).to receive(:can_pay_for?).with(order).and_return false
      end

      it "do not changes order's state" do
        expect { subject }.not_to change { order.state }
      end

      it "do not changes user's balance" do
        expect { subject }.not_to change { user.balance }
      end

      it { is_expected.to be_falsey }
    end
  end
end
