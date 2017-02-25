require 'rails_helper'

describe Api::V1::SessionsController do
  describe 'POST #create' do
    let!(:existing_user) { create(:user, password: 'SWAGLORD') }

    context 'successful' do
      it 'returns ' do
        session_attributes = {
          email: existing_user.email,
          password: 'SWAGLORD'
        }

        post :create, params: session_attributes

        expect(json_response['access_token']['device_id']).not_to be_nil
        expect(json_response['access_token']['token_value']).not_to be_nil
        expect(json_response['user']).not_to be_nil
        expect(json_response['user']['email']).not_to be_nil
      end
    end

    context 'fail' do
      it 'unable to find user - raise error' do
        session_attributes = {
          email: 'not@existing.com',
          password: 'SWAGLORD'
        }

        post :create, params: session_attributes

        expect(response.status).to eq 401
      end

      it 'wrong password - raise error' do
        session_attributes = {
          email: existing_user.email,
          password: 'SWAGLORDS'
        }

        post :create, params: session_attributes

        expect(response.status).to eq 401
      end
    end
  end
end

