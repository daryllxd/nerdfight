FactoryGirl.define do
  factory :team do
    name { "#{Faker::Name.name} Team" }
  end
end
