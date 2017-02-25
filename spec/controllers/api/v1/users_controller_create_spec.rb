require 'rails_helper'

RSpec.describe Api::V1::UsersController do
  describe 'POST #create' do
    context 'successful' do
      it 'returns a user_id and an access token with device_id and token_value' do
        new_user_attributes = {
          email: Faker::Internet.email,
          first_name: Faker::Name.first_name,
          handicap_value: Faker::Number.between(0, 50),
          last_name: Faker::Name.last_name,
          nickname: Faker::Name.last_name,
          location: Faker::Address.street_address,
          password: 'HASHTAG_YOLOSWAG!!!!',
          password_confirmation: 'HASHTAG_YOLOSWAG!!!!'
        }

        post :create, params: {user: new_user_attributes }

        expect(response.status).to eq 200
        expect(json_response['access_token']['device_id']).not_to be_nil
        expect(json_response['access_token']['token_value']).not_to be_nil
        expect(json_response['user']).not_to be_nil
        expect(json_response['user']['email']).not_to be_nil
      end
    end

    context 'failures' do
      it 'ActiveRecord::RecordInvalid--does not create a user' do
        new_user_attributes = {
          email: Faker::Internet.email,
          password: 'YOLOSWAG',
          password_confirmation: 'WRONG PASSWORD'
        }

        post :create, params: { user: new_user_attributes }

        expect(response.status).to eq 422
        expect(User.count).to eq 0
      end
    end
  end
end

