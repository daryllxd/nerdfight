require 'rails_helper'

RSpec.describe Match, type: :model do
  describe 'relationships' do
    it { should have_many(:teams) }
    it { should have_many(:match_questions) }
    it { should have_many(:questions).through(:match_questions) }
  end
end
