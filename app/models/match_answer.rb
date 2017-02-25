# == Schema Information
#
# Table name: match_answers
#
#  id         :integer          not null, primary key
#  answer_id  :integer
#  match_id   :integer
#  team_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_match_answers_on_answer_id  (answer_id)
#  index_match_answers_on_match_id   (match_id)
#  index_match_answers_on_team_id    (team_id)
#

class MatchAnswer < ApplicationRecord
  belongs_to :answer
  belongs_to :match
  belongs_to :team
end
