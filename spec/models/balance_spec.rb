require 'rails_helper'

RSpec.describe Balance, type: :model do
  describe '.validations' do
    context 'when valid' do
      subject { Balance.new user: user, manager: user }

      let!(:group) { create :group }
      let!(:user) { create :user, current_group: group }
      before do
        create :user_group, user: user, group: group, balance: 5
      end

      it { is_expected.to validate_presence_of :user }
      it { is_expected.to validate_presence_of :group }
      it { is_expected.to validate_presence_of :amount }
      it { is_expected.to validate_numericality_of(:amount) }
      it { is_expected.to validate_presence_of :manager }
      it do
        is_expected.not_to allow_value(-6).for(:amount)
          .with_message "User's balance cannot be negative"
      end
      it { is_expected.to allow_value(-5).for :amount }
    end
  end

  describe '#update' do
    subject { Balance.new(attributes).update }

    let!(:group) { create :group }
    let!(:group2) { create :group }
    let!(:user) { create :user, current_group: group2 }
    let!(:user_group1) do
      create :user_group, user: user, group: group, balance: 30
    end
    let!(:user_group2) do
      create :user_group, user: user, group: group2, balance: 25
    end
    let!(:manager) { create :user }

    context 'when valid attributes' do
      let(:attributes) do
        { user: user, group: group, amount: 100, manager: manager }
      end

      it { is_expected.to be_truthy }

      it "updates user's balance" do
        expect {
          subject
          user_group1.reload
        }.to change { user_group1.balance }.to 130
      end

      it 'creates new activity record' do
        expect { subject }.to change(Activity, :count).by 1
      end

      it 'sends notification about balance changes' do
        expect {
          subject
        }.to change(BalanceUpdatedWorker.jobs, :size).by 1
      end
    end

    context 'when invalid attributes' do
      let(:attributes) { { user: user, group: group, amount: '' } }

      it { is_expected.to be_falsey }

      it "do not change user's balance" do
        expect {
          subject
          user_group1.reload
        }.not_to change { user_group1.balance }
      end
    end
  end
end
