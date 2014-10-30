require 'rails_helper'

RSpec.describe ParseInstallation, type: :model do
  it 'has a valid factory' do
    expect(create :parse_installation).to be_valid
  end
end
