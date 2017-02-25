class Api::V1::UsersController < ApiController
  include Documentation::UsersController

  skip_before_action :ensure_access_token_is_valid, only: :create

  def create
    new_user = Users::CreateService.new(new_user_params: create_params).call

    if new_user.valid?
      render json: {
        access_token: AccessTokenPresenter.new(model: new_user.access_token).present,
        user: UserPresenter.new(model: new_user.user).present
      }
    else
      render_errors_for(new_user)
    end
  end

  def update
    updated_user = Users::UpdateService.new(user: current_user, attributes: params[:user]).call
    render json: { user: UserPresenter.new(model: updated_user).present }
  end

  private

  def create_params
    params.require(:user).permit(
      :email,
      :first_name,
      :handicap_value,
      :last_name,
      :nickname,
      :location,
      :ghin,
      :password,
      :password_confirmation)
  end
end
