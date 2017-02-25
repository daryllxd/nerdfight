# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  first_name             :string
#  last_name              :string
#  nickname               :string
#  location               :string
#  ghin                   :string
#  confirmation_token     :string
#  invited_by_user_id     :integer
#  phone_number           :string
#  handicap_value         :integer
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should belong_to(:team) }

    it { should have_many(:access_tokens) }
  end

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  it { should validate_presence_of(:first_name) }
  it { should validate_length_of(:first_name).is_at_least(2).is_at_most(72) }

  it { should validate_presence_of(:last_name) }
  it { should validate_length_of(:last_name).is_at_least(2).is_at_most(72) }
end
