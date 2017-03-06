class AddPointValueToMatchQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :match_questions, :point_value, :integer, null: false, default: 0
  end
end
