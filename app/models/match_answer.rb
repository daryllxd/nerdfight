# == Schema Information
#
# Table name: match_answers
#
#  id                :integer          not null, primary key
#  answer_id         :integer
#  match_id          :integer
#  team_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  match_question_id :integer
#  is_correct        :boolean          default(FALSE), not null
#
# Indexes
#
#  index_match_answers_on_answer_id                      (answer_id)
#  index_match_answers_on_match_id                       (match_id)
#  index_match_answers_on_match_question_id              (match_question_id)
#  index_match_answers_on_match_question_id_and_team_id  (match_question_id,team_id) UNIQUE
#  index_match_answers_on_team_id                        (team_id)
#

class MatchAnswer < ApplicationRecord
  validates :match_question, presence: true
  validates :match, presence: true
  validates :team, presence: true

  validates :match, uniqueness: { scope: [:team, :match_question] }
  validates :match_question, uniqueness: { scope: [:team] }

  belongs_to :answer
  belongs_to :match_question
  belongs_to :match
  belongs_to :team

  def self.of_team(team:)
    where(team: team)
  end
end
