# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :parse_installation do
    user
    sequence(:parse_object_id) { |n| "obj-#{n}" }
  end
end
