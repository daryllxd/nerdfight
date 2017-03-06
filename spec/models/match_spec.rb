require 'rails_helper'

RSpec.describe Match, type: :model do
  describe 'relationships' do
    it { should have_many(:match_answers) }
    it { should have_many(:match_questions) }
    it { should have_many(:questions).through(:match_questions) }
    it { should have_many(:teams) }
  end

  describe '#add_question' do
    let!(:match) { create(:match) }
    let!(:question) { create(:question) }

    it 'adds a question and applies a corresponding point value for that question' do
      match.add_question(question: question, point_value: 30)

      expect(match.questions).to include question
      expect(match.match_questions.first.point_value).to eq 30
    end

    it 'without a point value specified, it will have a point value of 0' do
      match.add_question(question: question)

      expect(match.questions).to include question
      expect(match.match_questions.first.point_value).to eq 0
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

  describe '#total_point_value_for_team' do
    it 'works' do
      match = create(:match)
      question1 = create(:question, :with_answers)
      question2 = create(:question, :with_answers)
      question3 = create(:question, :with_answers)

      match.add_question(question: question1, point_value: 5)
      match.add_question(question: question2, point_value: 20)
      match.add_question(question: question3, point_value: 30)

      team1 = create(:team, match: match)
      team2 = create(:team, match: match)

      match.match_answers.create(
        team: team1,
        match_question: match.match_question_for(question: question1),
        is_correct: true
      )

      match.match_answers.create!(
        team: team1,
        match_question: match.match_question_for(question: question2),
        is_correct: true
      )

      match.match_answers.create!(
        team: team1,
        match_question: match.match_question_for(question: question3),
        is_correct: false
      )


      expect(match.total_point_value_for(team: team1)).to eq 25
      expect(match.total_point_value_for(team: team2)).to eq 0
    end
  end
end
