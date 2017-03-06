class ReferenceMatchQuestionInMatchAnswers < ActiveRecord::Migration[5.0]
  def change
    add_reference :match_answers, :match_question, index: true
    add_column :match_answers, :is_correct, :boolean, default: false, null: false
  end
end
