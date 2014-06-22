require_relative '../../app/presenters/dictionary_presenter'

RSpec.describe DictionaryPresenter do
  let(:order1) { double "Order", created_at: Date.parse("2014-06-22") }
  let(:order2) { double "Order", created_at: Date.parse("2014-06-22") }
  let(:order3) { double "Order", created_at: Date.parse("2014-06-21") }
  let(:collection) { [order1, order2, order3] }

  describe '#as_dictionary' do
    subject { DictionaryPresenter.new(collection).as_dictionary }
    it 'combine items by created date' do
      is_expected.to eq({
        "2014-06-22" => [order1, order2],
        "2014-06-21" => [order3]
      })
    end
  end
end
