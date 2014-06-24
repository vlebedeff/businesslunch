require 'rails_helper'

describe OrderDecorator do
  describe '#state' do
    subject { OrderDecorator.new(order).state }
    context 'when state is paid' do
      let(:order) { double "Order", state: 'paid' }
      it 'decorates state as Paid label' do
        is_expected.to eq '<span class="label label-success">Paid</span>'
      end
    end

    context 'when state is not paid' do
      let(:order) { double "Order", state: 'pending' }
      it 'decorates state as Pending Payment label' do
        is_expected.to eq(
          '<span class="label label-danger">Pending Payment</span>')
      end
    end
  end
end
