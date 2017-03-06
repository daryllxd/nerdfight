FactoryGirl.define do
  factory :question do
    question_text { Faker::Lorem.sentence }

    trait :with_answers do
      after(:create) do |question|
        wrong_answer = create(:answer, question: question)
        right_answer = create(:answer, question: question)
      end
    end
  end
end
