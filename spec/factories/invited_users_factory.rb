FactoryGirl.define do
  factory :invited_user do
    first_name { Faker::Name.first_name }
    handicap_value { Faker::Number.between(0, 50) }
    last_name { Faker::Name.last_name }
    phone_number { Faker::PhoneNumber.phone_number }
  end
end
