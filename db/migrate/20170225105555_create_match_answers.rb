class CreateMatchAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :match_answers do |t|
      t.references :answer
      t.references :match
      t.references :team

      t.timestamps
    end
  end
end
