require 'rails_helper'

describe Matches::AnswerService do
  let!(:execute) { proc { |params| described_class.new(params).call } }

  context 'successful' do
    it 'answers a question for the team' do
      question = create_question
      team = create(:team)
      match = create(:match)
      match.add_question(question)

      answer_to_question = execute.call(
        answer_question_attributes: {
        match: match,
        team: team,
        answer: question.correct_answer
      }
      )

      expect(answer_to_question.answer).to eq question.correct_answer
      expect(answer_to_question.match).to eq match
      expect(answer_to_question.team).to eq team
    end
  end
end
