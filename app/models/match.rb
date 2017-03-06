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

  def add_question(question)
    match_questions.create(question: question)
  end

  def set_point_value_for(question:, point_value:)
    if found_question = match_questions.find_by(question: question)
      found_question.update_attributes(point_value: point_value)
    else
      raise "No question found for match #{id} and question #{question.id}"
    end
  end

  def point_value_for(question:)
    if found_question = match_questions.find_by(question: question)
      found_question.point_value
    else
      raise "No question found for match #{id} and question #{question.id}"
    end
  end
end
