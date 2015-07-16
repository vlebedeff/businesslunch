# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
    group
    user
    action "MyString"
    subject factory: :user
  end
end
