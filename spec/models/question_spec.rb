require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should validate_presence_of(:question_text) }

  describe 'relationships' do
    it { should belong_to(:correct_answer) }
    it { should have_many(:answers) }
  end

  context '#correct_answer' do
    it 'gets the correct answer' do
      question = create(:question, question_text: 'What is the capital of the Philippines?')

      answer1 = create(:answer, name: 'Manila')
      answer2 = create(:answer, name: 'Davao')
      answer3 = create(:answer, name: 'Cebu')

      question.set_correct_answer_as(answer1)
      expect(question.correct_answer).to eq answer1
    end
  end
end
