# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    user
    menu_set

    trait :paid do
      state 'paid'
    end
  end
end
