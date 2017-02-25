class AccessTokens::DestroyService
  attr_reader :device_id, :found_token

  def initialize(device_id:)
    @device_id = device_id
  end

  def call
    found_access_token = AccessToken.find_by_device_id(device_id)

    if found_access_token
      found_access_token.destroy
      return true
    else
      fail Errors::InvalidCredentialsError
    end
  end
end
