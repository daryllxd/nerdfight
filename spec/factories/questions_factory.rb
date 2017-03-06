FactoryGirl.define do
  factory :question do
    question_text { Faker::Lorem.sentence }

    trait :with_answers do
      after(:create) do |question|
        wrong_answer = create(:answer, question: question, name: 'wrong')
        right_answer = create(:answer, question: question, name: 'right')
        question.set_correct_answer_as(right_answer)
      end
    end
  end
end
