require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:question) }
  end

  describe 'relationships' do
    it { should belong_to(:question) }
  end
end
