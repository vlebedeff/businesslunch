# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :menu_set do
    name "1st menu set"
    details ""
    available_on { Date.current }
  end
end
