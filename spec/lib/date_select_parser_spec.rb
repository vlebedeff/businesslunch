require 'date_select_parser'

RSpec.describe DateSelectParser do
  let(:attrs) do
    {
      "begin_on(1i)" => '2014',
      "begin_on(2i)" => 'June',
      "begin_on(3i)" => '10'
    }
  end
  describe '#to_date' do
    subject { DateSelectParser.new("begin_on", attrs).to_date }
    it { is_expected.to eq Date.parse('2014-June-10') }
  end
end
