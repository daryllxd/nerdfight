RSpec.describe NullModel do
  it 'properties' do
    null_model = NullModel.new

    expect(null_model.valid?).to be false
  end
end
