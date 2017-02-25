require 'rails_helper'

RSpec.describe Api::V1::UsersController do
  describe 'PUT #update' do
    let!(:existing_user) { create(:user) }

    context 'with token' do
      before(:each) do
        allow(controller).to receive(:ensure_access_token_is_valid).and_return(true)
        allow(controller).to receive(:current_user).and_return(existing_user)
      end

      context 'successful' do
        it 'edits and returns the user' do
          edit_user_attributes = {
            first_name: "Alice",
            last_name: Faker::Name.last_name
          }

          put :update, params: { user: edit_user_attributes }

          expect(response.status).to eq 200
          expect(json_response['user']).not_to be_nil
          expect(json_response['user']['first_name']).to eq "Alice"
        end
      end

      context 'failures' do
        it 'ActiveRecord::RecordInvalid--does not update the other fields' do
          edit_user_attributes = {
            first_name: 'Bob',
            last_name: ''
          }

          put :update, params: { user: edit_user_attributes }

          expect(response.status).to eq 400
          expect(json_response['error']).to include "can't be blank", "too short"
        end

        it 'WrongParamsError--does not update the other fields' do
          edit_user_attributes = {
            first_name: 'Chris',
            literally_a_wrong_parameter: 'Sourcepad'
          }

          put :update, params: { user: edit_user_attributes }

          expect(response.status).to eq 400
          expect(json_response['error']).to eq "Wrong key 'literally_a_wrong_parameter'."
        end
      end
    end

    context 'no access token' do
      it 'is unauthorized' do
        put :update, params: { user: { first_name: 'hehe' } }

        expect(response.status).to eq 401
      end
    end
  end
end

