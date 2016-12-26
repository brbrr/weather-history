FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email2-#{n}@example.com" }
    password '12345678'
  end
end
