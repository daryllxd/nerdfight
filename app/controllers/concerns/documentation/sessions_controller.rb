module Documentation::SessionsController
  extend ActiveSupport::Concern

  included do
    swagger_controller :sessions, "Session Management"

    swagger_api :create do
      summary 'Signs in a user. Also accessible via api/v1/sign_in.'

      param :form, 'email', :string, :required, 'Email', example: 'darylls@sourcepad.com'
      param :form, 'password', :string, :required, 'Password'

      response :success
      response 401
    end

    swagger_api :destroy do
      summary 'Signs out a user. Also accessible via api/v1/sign_out.'

      param :form, 'device_id', :string, :required, 'Device ID.'

      response :success
      response 401
    end
  end
end
