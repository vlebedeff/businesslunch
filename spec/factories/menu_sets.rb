# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :menu_set do
    sequence(:name) { |n| "#{n}st menu set" }
    details ""
    available_on { Date.current }
    price 35
  end
end
