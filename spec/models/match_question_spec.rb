require 'rails_helper'

RSpec.describe MatchQuestion, type: :model do
  describe 'relationships' do
    it { should belong_to(:match) }
    it { should belong_to(:question) }
  end
end
