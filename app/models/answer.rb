# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  name        :string
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_answers_on_question_id  (question_id)
#

class Answer < ApplicationRecord
  validates :name, presence: true
  validates :question, presence: true

  belongs_to :question
end
