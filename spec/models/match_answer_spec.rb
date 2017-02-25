require 'rails_helper'

RSpec.describe MatchAnswer, type: :model do
  describe 'relationships' do
    it { should belong_to(:match) }
    it { should belong_to(:answer) }
    it { should belong_to(:team) }
  end
end
