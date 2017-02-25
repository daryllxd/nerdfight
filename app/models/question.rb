# == Schema Information
#
# Table name: questions
#
#  id                :integer          not null, primary key
#  question_text     :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  correct_answer_id :integer
#

class Question < ApplicationRecord
  validates :question_text, presence: true

  belongs_to :correct_answer, class_name: Answer
  has_many :answers

  def set_correct_answer_as(answer)
    update_attributes(correct_answer: answer)
  end
end
