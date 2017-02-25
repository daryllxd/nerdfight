# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  match_id   :integer
#
# Indexes
#
#  index_teams_on_match_id  (match_id)
#

class Team < ApplicationRecord
  validates :name, presence: true

  belongs_to :match
  has_many :users
end
