require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'relationships' do
    it { should belong_to(:match) }

    it { should have_many(:match_answers) }
    it { should have_many(:users) }
  end

  it { should validate_presence_of(:name) }
end
