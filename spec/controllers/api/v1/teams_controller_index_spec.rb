require 'rails_helper'

RSpec.describe Api::V1::TeamsController do
  describe 'GET #index' do
    context 'with token' do
      before(:each) do
        allow(controller).to receive(:ensure_access_token_is_valid).and_return(true)
        allow(controller).to receive(:current_user).and_return(true)
      end

      context 'successful' do
        it 'given a match id, it returns the teams and their constituent users' do
          match = create(:match)
          team1 = create(:team, match: match)
          team2 = create(:team, match: match)
          team1_member = create(:user, team: team1)
          team2_member = create(:user, team: team2)

          get :index, params: { match_id: match.id }

          expect(json_response['teams'].count).to eq 2
        end
      end
    end
  end
end
