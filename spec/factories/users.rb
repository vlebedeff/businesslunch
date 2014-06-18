# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user-#{n}@example.com" }
    password 'password'

    factory :user_example_com do
      email 'user@example.com'
      confirmed_at { 1.minute.ago }
    end
  end
end
