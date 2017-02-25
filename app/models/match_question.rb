# == Schema Information
#
# Table name: match_questions
#
#  id          :integer          not null, primary key
#  match_id    :integer
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_match_questions_on_match_id     (match_id)
#  index_match_questions_on_question_id  (question_id)
#

class MatchQuestion < ApplicationRecord
  validates :match, presence: true
  validates :question, presence: true

  belongs_to :match
  belongs_to :question
end
