FactoryGirl.define do
  factory :user do
    email "test_email@foo.com"
    password "password"
    first_name "Jane"
    last_name "Doe"
  end
end