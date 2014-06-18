# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user-#{n}@example.com" }
    password 'password'
    confirmed_at { 1.minute.ago }

    factory :user_example_com do
      email 'user@example.com'
    end
  end
end
