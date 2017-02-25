module Documentation::UsersController
  extend ActiveSupport::Concern

  included do
    swagger_controller :users, "User Management"

    swagger_api :create do
      summary 'Creates users.'

      param :form, 'user[email]', :string, :required, 'Email', example: 'darylls@sourcepad.com'
      param :form, 'user[first_name]', :string, :required, 'Name'
      param :form, 'user[last_name]', :string, :required, 'Last Name'
      param :form, 'user[nickname]', :string, :required, 'Nickname'
      param :form, 'user[password]', :string, :required, 'Password'
      param :form, 'user[password_confirmation]', :string, :required, 'Password Confirmation'
      param :form, 'user[location]', :string, :required, 'Location'
      param :form, 'user[ghin]', :string,:optional, 'GHIN number'

      response :success
      response :unprocessable_entity
    end
  end
end
