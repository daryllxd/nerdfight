FactoryGirl.define do
  factory :access_token do
    device_id { Faker::Crypto.md5 }
    token_value { Faker::Crypto.md5 }
  end
end
