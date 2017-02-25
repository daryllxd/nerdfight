class Api::V1::SessionsController < ApiController
  include Documentation::SessionsController

  skip_before_action :ensure_access_token_is_valid

  def create
    user_signing_in = User.find_for_database_authentication(email: params[:email])

    if user_signing_in && user_signing_in.valid_password?(params[:password])
      token = AccessTokens::CreateService.new(user: user_signing_in).call

      render json: {
        access_token: AccessTokenPresenter.new(model: token).present,
        user: UserPresenter.new(model: user_signing_in).present
      }
    else
      fail Errors::InvalidCredentialsError
    end
  end

  def destroy
    destroyed_token = AccessTokens::DestroyService.new(device_id: request_details[:device_id]).call

    if destroyed_token
      render json: { success: true }
    else
      render_error
    end
  end
end
