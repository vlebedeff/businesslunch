require 'rails_helper'

RSpec.describe UserDecorator, type: :decorator do
  describe '#amount' do
    subject { UserDecorator.new(user).amount }

    context 'when amount is more than lunch price' do
      let(:user) { double amount: 100 }

      it do
        is_expected.to eq '<span class="text-success">Balance: 100 Lei</span>'
      end
    end

    context 'when amount is less than lunch price' do
      let(:user) { double amount: 30 }

      it do
        is_expected.to eq '<span class="text-danger">Balance: 30 Lei</span>'
      end
    end
  end
end
