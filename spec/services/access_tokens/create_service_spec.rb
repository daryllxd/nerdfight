require 'rails_helper'

describe AccessTokens::CreateService do
  context 'successful' do
    it 'creates an encrypted access token' do
      new_access_token = AccessTokens::CreateService.new(user: create(:user)).call

      expect(new_access_token).to be_a_kind_of(AccessToken)
      expect(new_access_token.token_value).not_to be_blank
      expect(new_access_token.device_id).not_to be_blank
    end
  end
end

