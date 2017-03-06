class TeamPresenter < BasePresenter
  def present
    {
      id: model.id,
      name: model.name,
      users: model.users.map { |user| present_user(user) }
    }
  end

  def present_user(user)
    {
      id: user.id,
      first_name: user.first_name
    }
  end
end
