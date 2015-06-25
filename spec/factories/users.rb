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

    trait :groupped do
      ignore do
        balance 0
        group nil
      end

      after(:create) do |user, evaluator|
        group = evaluator.group || create(:group)
        user.join_group group
        user_group = user.user_groups.find_by(group: user.current_group)
        user_group.update_column :balance, evaluator.balance
      end
    end

    factory :user_example_com do
      email 'user@example.com'
    end

    factory :manager_example_com, traits: [:manager] do
      email 'manager@example.com'
    end

    factory :admin_example_com, traits: [:admin] do
      email 'admin@example.com'
    end
  end
end
