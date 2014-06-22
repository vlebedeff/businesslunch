require 'rails_helper'

RSpec.describe DictionaryPresenter do
  let(:order1) { double "Order", created_at: DateTime.now }
  let(:order2) { double "Order", created_at: DateTime.now }
  let(:order3) { double "Order", created_at: 1.days.ago }
  let(:collection) { [order1, order2, order3] }

  describe '#as_dictionary' do
    subject { DictionaryPresenter.new(collection).as_dictionary }
    it 'combine items by created date' do
      is_expected.to eq({
        Date.current.to_s => [order1, order2],
        1.day.ago.to_date.to_s => [order3]
      })
    end
  end
end
