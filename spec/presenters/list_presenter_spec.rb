require_relative '../../app/presenters/list_presenter'

RSpec.describe ListPresenter do
  let(:menu_set1) {
    double "MenuSet", id: 1, name: "1st menu set", details: '1'
  }
  let(:menu_set2) {
    double "MenuSet", id: 2, name: "2nd menu set", details: '2'
  }

  describe '#as_collection' do
    subject { ListPresenter.new([menu_set1, menu_set2]).as_collection }
    it do
      is_expected.to eq [["1st menu set", '1', 1], ["2nd menu set", '2', 2]]
    end
  end
end
