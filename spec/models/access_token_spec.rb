# == Schema Information
#
# Table name: access_tokens
#
#  id                       :integer          not null, primary key
#  encrypted_token_value    :string
#  encrypted_token_value_iv :string
#  user_id                  :integer
#  device_id                :string           not null
#
# Indexes
#
#  index_access_tokens_on_user_id  (user_id)
#

describe AccessToken, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:encrypted_token_value) }
  it { should validate_presence_of(:device_id) }

  describe 'uniqueness validators' do
    # Create a model first, since the database will not allow an empty field, then test the model for uniqueness
    subject { create(:access_token) }
    it { should validate_uniqueness_of(:device_id) }
  end

  context '#compare_tokens' do
    let!(:user) { create(:user) }

    describe 'successful' do
      it 'given the same device id, it should return the token itself' do
        access_token = AccessTokens::CreateService.new(user: user).call

        authenticated_token = AccessToken.compare_tokens(
          token_value: access_token.token_value,
          device_id: access_token.device_id
        )

        expect(authenticated_token).to be_a_kind_of(AccessToken)
      end
    end

    describe 'failure' do
      it 'given the same device id, if the token is wrong, it should raise an AccessTokenError' do
        access_token = AccessTokens::CreateService.new(user: user).call

        expect{ AccessToken.compare_tokens(
          token_value: "THE WRONGEST ACCESS TOKEN IN THE WORLD!",
          device_id: access_token.device_id
        ) }.to raise_error(Errors::InvalidAccessTokenError)
      end
    end
  end
end
