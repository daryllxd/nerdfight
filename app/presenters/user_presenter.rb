class UserPresenter < BasePresenter
  def present
    {
      email: model.email,
      id: model.id,
      first_name: model.first_name,
      last_name: model.last_name
    }
  end
end
