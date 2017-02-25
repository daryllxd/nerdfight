class CreateMatchQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :match_questions do |t|
      t.references :match
      t.references :question

      t.timestamps
    end
  end
end
