require 'rails_helper'

RSpec.describe Freeze, type: :model do
  it 'has a valid factory' do
    expect(create :freeze).to be_valid
  end

  let!(:group) { create :group }

  describe '.associations' do
    it { is_expected.to belong_to :group }
  end

  describe '.after_create' do
    let(:freeze) { build :freeze, frozen_on: nil }
    it "set frozen_on" do
      expect {
        freeze.save
        freeze.reload
      }.to change { freeze.frozen_on }
    end
  end

  describe '.frozen?' do
    subject { Freeze.frozen?(group) }

    context 'when frozen_on for today exists' do
      let!(:freeze) { create :freeze, group: group }
      it { is_expected.to be_truthy }
    end

    context 'when frozen_on for today is not exists' do
      it { is_expected.to be_falsey }
    end
  end

  describe '.unfreeze' do
    subject { Freeze.unfreeze(group) }

    context 'when freeze exists' do
      before { create :freeze, group: group }

      it "removes today freeze" do
        expect { subject }.to change(Freeze, :count).by -1
      end
    end

    context 'when freeze do not exists' do
      it "dont removes anything" do
        expect { subject }.not_to change(Freeze, :count)
      end
    end
  end
end
