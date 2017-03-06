require 'rails_helper'

RSpec.describe Match, type: :model do
  describe 'relationships' do
    it { should have_many(:match_answers) }
    it { should have_many(:match_questions) }
    it { should have_many(:questions).through(:match_questions) }
    it { should have_many(:teams) }
  end

  describe '#add_question' do
    it 'adds a question' do
      match = create(:match)
      question = create(:question)

      match.add_question(question)

      expect(match.questions).to include question
    end
  end

  describe '#set_point_value_for and #point_value_for' do
    it 'works' do
      match = create(:match)
      question = build(:question)
      match.add_question(question)

      match.set_point_value_for(question: question, point_value: 5)

      expect(match.point_value_for(question: question)).to eq 5
    end
  end
end
