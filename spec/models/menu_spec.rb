require 'rails_helper'

RSpec.describe Menu, type: :model do
  describe '.validation' do
    context 'when valid' do
      subject { Menu.new }
      it { is_expected.to validate_presence_of :available_on }
    end
  end

  describe '#save' do
    subject { Menu.from_params(menu_attrs).save }

    context 'when valid attributes' do
      let(:menu_attrs) do
        ActionController::Parameters.new(
          "available_on(1i)" => "2014",
          "available_on(2i)" => "6",
          "available_on(3i)" => "24",
          "menu_set" => {
            "0" => { "name"=>"1st menu set" },
            "1" => { "name"=>"2nd menu set" },
            "2" => { "name"=>"Diet menu" } })
      end

      it { is_expected.to be_truthy }

      it "creates 3 menu sets" do
        expect {
          subject
        }.to change(MenuSet, :count).by(3)
      end
    end

    context 'when invalid attributes' do
      let(:menu_attrs) do
        ActionController::Parameters.new(
          "menu_set"=>{
            "0" => { "name"=>"1st menu set" },
            "1" => { "name"=>"2nd menu set" },
            "2" => { "name"=>"Diet menu" } })
      end

      it { is_expected.to be_falsey }
    end
  end
end
