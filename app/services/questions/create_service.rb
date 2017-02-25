module Questions
  class CreateService < BaseService
    attr_reader :new_question_attributes

    def initialize(new_question_attributes:)
      @new_question_attributes = new_question_attributes
    end

    def call
      ensure_no_excess_attributes(new_question_attributes.keys, editable_question_attributes)

      begin
        ActiveRecord::Base.transaction do
          new_question = Question.create!(question_attributes)

          new_question_attributes[:answers].each do |new_answer_attributes|
            answer = new_question.answers.create!(allowed_answer_attributes(new_answer_attributes))
            new_question.set_correct_answer_as(answer) if new_answer_attributes[:correct_answer]
          end

          new_question
        end
      rescue Exception => exception
        rescue_with_handler(exception) || raise
      end
    end

    def editable_question_attributes
      %i{question_text answers}
    end

    def question_attributes
      {
        question_text: new_question_attributes[:question_text]
      }
    end

    def allowed_answer_attributes(new_answer_attributes)
      {
        name: new_answer_attributes[:name]
      }
    end
  end
end

