class Api::V1::TeamsController < ApiController
  skip_before_action :ensure_access_token_is_valid, only: :create

  def index
    match = Match.find_by(id: params[:match_id])

    teams = match.teams

    render json: { teams: TeamPresenter.present_collection(teams) }
  end
end
