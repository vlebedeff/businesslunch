require 'rails_helper'

RSpec.describe Balance, type: :model do
  subject { Balance.new }

  it { is_expected.to validate_presence_of :user }
  it { is_expected.to validate_presence_of :amount }
  it { is_expected.to validate_numericality_of(:amount) }
  it { is_expected.to validate_presence_of :manager }

  describe '#update' do
    subject { Balance.new(attributes).update }

    let!(:user) { create :user, amount: 30 }
    let!(:manager) { create :user }

    context 'when valid attributes' do
      let(:attributes) { { user: user, amount: 100, manager: manager } }

      it { is_expected.to be_truthy }

      it "updates user's balance" do
        expect {
          subject
          user.reload
        }.to change { user.amount }.to 130
      end

      it 'creates new activity record' do
        expect { subject }.to change(Activity, :count).by 1
      end
    end

    context 'when invalid attributes' do
      let(:attributes) { { user: user, amount: '' } }

      it { is_expected.to be_falsey }

      it "do not change user's balance" do
        expect {
          subject
          user.reload
        }.not_to change { user.amount }
      end
    end
  end
end
