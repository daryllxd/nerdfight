require 'rails_helper'

RSpec.describe Api::V1::SessionsController do
  describe 'POST #destroy' do
    context 'successful' do
      it 'destroys the token and returns a success true' do
        access_token = create(:access_token)

        post :destroy, params: { device_id: access_token.device_id }

        expect(json_response['success']).to be_truthy
      end
    end

    context 'fail' do
      # This happens if the device id does not exist
      it 'returns an error' do
        post :destroy, params: { device_id: 'HUHUBELLS' }

        expect(response.status).to eq 401
      end
    end
  end
end

