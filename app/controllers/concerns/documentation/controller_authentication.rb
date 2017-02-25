module Documentation::ControllerAuthentication
  extend ActiveSupport::Concern

  module ClassMethods
    def has_token_authentication(api)
      api.param :header, 'AccessToken', :string, :optional, 'Access token'
      api.param :header, 'DeviceId', :string, :optional, 'Nerdfight-generated DeviceId (not the Apple device ID)'
    end
  end
end
