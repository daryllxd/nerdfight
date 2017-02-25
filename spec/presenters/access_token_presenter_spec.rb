describe AccessTokenPresenter do
  it {should be_a_kind_of(BasePresenter) }

  it 'returns the token_value and device_id' do
    user = create(:user)
    token = AccessTokens::CreateService.new(user: user).call

    presented_access_token = AccessTokenPresenter.new(model: token).present

    expect(presented_access_token.keys).to eq [:token_value, :device_id]
  end
end
