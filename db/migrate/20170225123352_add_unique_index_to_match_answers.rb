class AddUniqueIndexToMatchAnswers < ActiveRecord::Migration[5.0]
  def change
    add_index :match_answers, [:match_id, :team_id], unique: true
  end
end


