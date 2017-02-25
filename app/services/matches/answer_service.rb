module Matches
  class AnswerService < BaseService
    attr_reader :answer_question_attributes

    def initialize(answer_question_attributes:)
      @answer_question_attributes = answer_question_attributes
    end

    def call
      begin
        ActiveRecord::Base.transaction do
          MatchAnswer.create!(
            answer: answer_question_attributes[:answer],
            match: answer_question_attributes[:match],
            team: answer_question_attributes[:team]
          )
        end
      rescue StandardError => exception
        rescue_with_handler(exception) || raise
      end
    end
  end
end

