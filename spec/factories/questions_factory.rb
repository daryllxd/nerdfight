FactoryGirl.define do
  factory :question do
    question_text { Faker::Lorem.sentence }
  end
end
