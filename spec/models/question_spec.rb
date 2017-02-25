require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should validate_presence_of(:question_text) }

  it { should have_many(:answers) }

  context '#correct_answer' do
    it 'works' do
      question = create(:question, question_text: 'What is the capital of the Philippines?')

      answer1 = create(:answer, name: 'Manila')
      answer2 = create(:answer, name: 'Davao')
      answer3 = create(:answer, name: 'Cebu')

      expect(question.correct_answer).to eq answer1
    end
  end
end
