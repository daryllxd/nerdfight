require 'rails_helper'

RSpec.describe Match, type: :model do
  describe 'relationships' do
    it { should have_many(:teams) }
  end
end
