module ControllerAuthentication
  extend ActiveSupport::Concern

  def request_details
    @request_details || {
      token_value: request.headers['AccessToken'] || params[:token_value],
      device_id: request.headers['DeviceId'] || params[:device_id],
      user_id: request.headers['UserId'] ||params[:user_id]
    }
  end

  def ensure_access_token_is_valid
    fail Errors::InvalidAccessTokenError unless Rails.env.development? || AccessToken.compare_tokens(request_details)
  end

  def deny_access
    render json: { error: "Invalid credentials" }, status: :unauthorized
  end

  included do
    rescue_from Errors::InvalidAccessTokenError, with: :deny_access

    rescue_from Errors::InvalidCredentialsError do
      render json: { error: "Invalid credentials" }, status: :unauthorized
    end
  end
end

