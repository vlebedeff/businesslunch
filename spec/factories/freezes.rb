# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :freeze do
    frozen_on { Date.current }
  end
end
