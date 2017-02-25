require 'rails_helper'

describe Users::CreateService do
  context 'successful' do
    it 'creates a user and returns the user attributes and its corresponding access_token' do
      new_user_attributes = {
        email: Faker::Internet.email,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        password: 'HASHTAG_YOLOSWAG!!!!',
        password_confirmation: 'HASHTAG_YOLOSWAG!!!!'
      }

      new_user = Users::CreateService.new(new_user_params: new_user_attributes).call

      expect(new_user).to be_a_kind_of(NewUser)
      expect(new_user).to be_valid
    end

    it 'ghin can be duplicated if it is blank' do
      # Both of these have blank ghins
      new_user = Users::CreateService.new(new_user_params: attributes_for(:user).merge(password_confirmation: 'please123')).call
      new_user2 = Users::CreateService.new(new_user_params: attributes_for(:user).merge(password_confirmation: 'please123')).call

      expect(new_user2).to be_a_kind_of(NewUser)
      expect(new_user).to be_valid
    end
  end

  context 'failures' do
    describe 'user already exists' do
      it 'does not create a new user' do
        old_user = create(:user)
        new_user_attributes = attributes_for(:user, email: old_user.email, password: 'SOURCEPAD', password_confirmation: 'SOURCEPAD')

        uncreated_new_user = Users::CreateService.new(new_user_params: new_user_attributes).call

        expect(uncreated_new_user).not_to be_valid
      end
    end

    describe 'wrong password' do
      it 'does not create a new user (the new user is invalid)' do
        new_user_attributes = attributes_for(:user, password: 'HELLO', password_confirmation: 'WORLD')
        uncreated_new_user = Users::CreateService.new(new_user_params: new_user_attributes).call

        expect(uncreated_new_user).not_to be_valid
      end
    end

    describe 'no nickname (ActiveRecord error)' do
      it 'does not create a new user (the new user is invalid)' do
        new_user_attributes = attributes_for(:user, nickname: nil, password: 'HELLO', password_confirmation: 'HELLO')
        uncreated_new_user = Users::CreateService.new(new_user_params: new_user_attributes).call

        expect(uncreated_new_user).not_to be_valid
      end
    end
  end
end

