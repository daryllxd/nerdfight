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
end
