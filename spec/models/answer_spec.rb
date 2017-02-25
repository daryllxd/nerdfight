require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'relationships' do
    it { should belong_to(:question) }
  end
end
