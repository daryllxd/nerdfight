require 'rails_helper'

describe Users::UpdateService do
  context 'inheritance' do
    subject { Users::UpdateService.new(user: 1, attributes: 2) }

    it { should be_a(BaseService) }
  end

  let!(:user_to_update) { create(:user) }

  context 'successful' do
    it 'will attempt to update the attributes of editable attributes' do
      update_user_attributes = {
        first_name: "Swaggermeister",
        last_name: "McDoodles"
      }

      new_user = Users::UpdateService.new(
        user: user_to_update,
        attributes: update_user_attributes
      ).call

      expect(new_user.first_name).to eq "Swaggermeister"
      expect(new_user.last_name).to eq "McDoodles"
    end
  end

  context 'failures' do
    it 'fails database validation--raises an error' do
      expect {Users::UpdateService.new(
        user: user_to_update,
        attributes: { first_name: nil }
      ).call }.to raise_error(Errors::RecordInvalidError)
    end

    it 'has an unneeded attribute--raises an error' do
      expect {Users::UpdateService.new(
        user: user_to_update,
        attributes: { wrong_attribute: 'the_thing' }
      ).call }.to raise_error(Errors::WrongParamsError)

      begin
        Users::UpdateService.new(
          user: user_to_update,
          attributes: { wrong_attribute: 'the_thing' }
        ).call

      rescue Errors::WrongParamsError => e
        expect(e.to_s).to eq 'wrong_attribute'
      end
    end
  end
end
