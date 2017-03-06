require 'rails_helper'

RSpec.describe MatchQuestion, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:match) }

    it { should validate_numericality_of(:point_value) }

    it { should validate_presence_of(:question) }
  end

  describe 'relationships' do
    it { should belong_to(:match) }
    it { should belong_to(:question) }
  end
end
