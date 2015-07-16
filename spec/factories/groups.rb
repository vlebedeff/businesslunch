# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group do
    sequence(:name) { |n| "Group ##{n}" }
    currency_unit 'MDL'
  end
end
