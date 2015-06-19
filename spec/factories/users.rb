# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user-#{n}@example.com" }
    password 'password'
    confirmed_at { 1.minute.ago }

    trait :manager do
      roles [:manager]
    end

    trait :admin do
      roles [:admin]
    end

    factory :user_example_com do
      email 'user@example.com'
    end

    factory :manager_example_com, traits: [:manager] do
      email 'manager@example.com'
    end
  end
end
