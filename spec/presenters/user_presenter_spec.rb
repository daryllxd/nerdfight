RSpec.describe UserPresenter do
  it { should be_a(BasePresenter) }

  it 'returns user details' do
    user = create(:user)
    presented_user = UserPresenter.new(model: user).present

    expect(presented_user.keys).to eq [:email, :id, :first_name,:last_name]
  end
end
