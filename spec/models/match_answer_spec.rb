require 'rails_helper'

RSpec.describe MatchAnswer, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:answer) }
    it { should validate_presence_of(:match) }
    it { should validate_presence_of(:team) }
  end

  describe 'relationships' do
    it { should belong_to(:answer) }
    it { should belong_to(:match) }
    it { should belong_to(:team) }
  end
end
