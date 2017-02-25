# == Schema Information
#
# Table name: access_tokens
#
#  id                       :integer          not null, primary key
#  encrypted_token_value    :string
#  encrypted_token_value_iv :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  device_id                :string           not null
#  user_id                  :integer
#
# Indexes
#
#  index_access_tokens_on_user_id  (user_id)
#

class AccessToken < ApplicationRecord
  belongs_to :user

  validates :device_id, presence: true, uniqueness: true
  validates :encrypted_token_value, presence: true

  attr_encrypted :token_value, key: Rails.application.secrets.access_token_key

  def self.compare_tokens(token_value:, device_id:, user_id: nil)
    found_token = AccessToken.find_by_device_id(device_id)

    if found_token
      authenticated_token = Devise.secure_compare(token_value, found_token.token_value)

      if authenticated_token
        return found_token
      else
        fail Errors::InvalidAccessTokenError
      end
    end
  end
end
