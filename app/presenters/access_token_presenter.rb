class AccessTokenPresenter < BasePresenter
  def present
    {
      token_value: model.token_value,
      device_id: model.device_id
    }
  end
end
