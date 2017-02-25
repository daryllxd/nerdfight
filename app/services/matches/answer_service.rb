module Matches
  class AnswerService < BaseService
    attr_reader :answer_question_attributes

    def initialize(answer_question_attributes:)
      @answer_question_attributes = answer_question_attributes
    end

    def call
      MatchAnswer.create!(
        answer: answer_question_attributes[:answer],
        match: answer_question_attributes[:match],
        team: answer_question_attributes[:team]
      )
    end
  end
end

