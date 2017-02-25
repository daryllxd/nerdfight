# Returns the token
def create_access_token_for(user)
  AccessTokens::CreateService.new(user: user).call
end
