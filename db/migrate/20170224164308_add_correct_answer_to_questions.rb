class AddCorrectAnswerToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :correct_answer_id, :integer
  end
end
