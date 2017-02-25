# Value class just to hold in a user and their fresh token
class NewUser
  attr_reader :user, :access_token

  def initialize(user:, access_token:)
    @user = user
    @access_token= access_token
  end

  def valid?
    true
  end
end
