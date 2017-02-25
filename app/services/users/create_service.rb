class Users::CreateService
  attr_reader :new_user_params, :new_user

  def initialize(new_user_params:)
    @new_user_params = new_user_params
  end

  def call
    @new_user = User.new_with_session(new_user_attributes, 'NECESSARY_PARAMETER')

    if new_user.save
      new_access_token = AccessTokens::CreateService.new(user: new_user).call

      return NewUser.new(access_token: new_access_token, user: new_user)
    else
      # This is an invalid object
      return new_user
    end
  end

  def new_user_attributes
    {
      email: new_user_params[:email],
      first_name: new_user_params[:first_name],
      last_name: new_user_params[:last_name],
      password: new_user_params[:password],
      password_confirmation: new_user_params[:password_confirmation]
    }
  end
end
