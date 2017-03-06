# == Schema Information
#
# Table name: matches
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Match < ApplicationRecord
  has_many :match_answers
  has_many :match_questions
  has_many :questions, through: :match_questions
  has_many :teams

  def add_question(question:, point_value: 0)
    match_questions.create(question: question, point_value: point_value)
  end

  def set_point_value_for(question:, point_value:)
    if found_question = match_questions.find_by(question: question)
      found_question.update_attributes(point_value: point_value)
    else
      raise "No question found for match #{id} and question #{question.id}"
    end
  end

  def match_question_for(question:)
    match_questions.find_by(question: question)
  end

  def point_value_for(question:)
    if found_question = match_questions.find_by(question: question)
      found_question.point_value
    else
      raise "No question found for match #{id} and question #{question.id}"
    end
  end

  def total_point_value_for(team:)
    correct_answers
      .select("match_answers.*, match_questions.point_value")
      .joins("LEFT JOIN match_questions ON match_questions.id = match_answers.match_question_id")
      .where("team_id = ?", team.id)
      .map(&:point_value).reduce(:+) || 0
  end


  # scopes

  def correct_answers
    match_answers.where(is_correct: true)
  end
end
