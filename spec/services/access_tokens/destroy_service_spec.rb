require 'rails_helper'

describe AccessTokens::DestroyService do
  let!(:access_token) { create(:access_token) }

  context 'successful' do
    it 'destroys the token associated for the device' do
      access_token_is_destroyed = AccessTokens::DestroyService.new(device_id: access_token.device_id).call

      expect(access_token_is_destroyed).to be_truthy
      expect(AccessToken.count).to eq 0
    end
  end

  context 'unable to find the access token' do
    it 'raises an error' do
      expect { AccessTokens::DestroyService.new(device_id: 'NOT THE ID').call }.to raise_error(Errors::InvalidCredentialsError)
    end
  end
end

