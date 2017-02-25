class ApiController < ApplicationController
  include ControllerAuthentication
  include HandleObjectNotFound
  include HandleRecordInvalid
  include HandleWrongParams
  include Documentation::ControllerAuthentication

  skip_before_action :verify_authenticity_token
  before_action :ensure_access_token_is_valid

  rescue_from Errors::MissingParamsError, with: :render_error_if_params_are_not_present

  def current_user
    # For development/productivity purposes, you can authenticate yourself by just passing params[:user_id].
    @current_user || (Rails.env.development? ? User.find_by_id(params[:user_id]) : AccessToken.compare_tokens(request_details).user)
  end

  def ensure_params_are_present(param_sym)
    fail Errors::MissingParamsError.new(param_sym) unless params[param_sym]
  end

  def render_error_if_params_are_not_present(params)
    render json: { error: "'#{params}' is not present in the params hash." }, status: 422 and return
  end

  def render_error
    render json: { error: "Error" }, status: 401
  end

  def render_errors_for(active_record_object)
    render json: { errors: active_record_object.errors.full_messages }, status: 422
  end
end
