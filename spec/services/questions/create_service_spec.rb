require 'rails_helper'

RSpec.describe Questions::CreateService do
  let!(:execute) { proc { |params| described_class.new(params).call } }

  context 'successful' do
    it 'creates a question and an answer' do
      new_question_attributes = {
        question_text: 'What is the name of our planet?',
        answers: [
          { name: 'Mercury' },
          { name: 'Venus' },
          { name: 'Earth', correct_answer: true }
      ]
      }

      new_question = execute.call(
        new_question_attributes: new_question_attributes
      )

      expect(new_question.question_text). to eq new_question_attributes[:question_text]
      expect(new_question.answers.count). to eq 3
      expect(new_question.correct_answer.name). to eq 'Earth'
    end
  end

  context 'failures' do
    it 'wrong keys on Question--raises Errors::WrongParamsError' do
      new_question_attributes = {
        question_text: 'What is the name of our planet?',
        wrong_key: 'This is a wrong key',
        answers: [ { name: 'Earth', correct_answer: true } ]
      }

      begin
        execute.call(
          new_question_attributes: new_question_attributes
        )
      rescue Errors::WrongParamsError => e
        expect(e.message).to include 'wrong_key'
      end

      expect(Question.exists?).to be false
    end

    it 'fails database validation on Question--raises Errors::RecordInvalidError' do
      new_question_attributes = {}

      begin
        execute.call(
          new_question_attributes: new_question_attributes
        )
      rescue Errors::RecordInvalidError => e
        expect(e.message).to include "can't be blank"
      end

      expect(Question.exists?).to be false
    end

    it 'fails database validation on Answer--raises Errors::RecordInvalidError and does not create a Question' do
      new_question_attributes = {
        question_text: 'If you were an animal, why?',
        answers: [
          { }
      ]
      }

      begin
        execute.call(
          new_question_attributes: new_question_attributes
        )
      rescue Errors::RecordInvalidError => e
        expect(e.message).to include "can't be blank"
      end

      expect(Question.exists?).to be false
      expect(Answer.exists?).to be false
    end
  end
end
