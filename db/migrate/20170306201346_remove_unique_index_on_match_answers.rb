class RemoveUniqueIndexOnMatchAnswers < ActiveRecord::Migration[5.0]
  def change
    remove_index :match_answers, name: 'index_match_answers_on_match_id_and_team_id'
  end
end
