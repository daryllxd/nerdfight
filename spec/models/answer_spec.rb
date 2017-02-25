require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should validate_presence_of(:name) }

  describe 'relationships' do
    it { should belong_to(:question) }
  end
end
