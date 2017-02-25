# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
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
#  first_name             :string
#  last_name              :string
#  confirmation_token     :string
#  team_id                :integer
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_team_id               (team_id)
#

class User < ApplicationRecord
  include Users::Scopes

  PASSWORD_LENGTH = 6..72
  NAME_LENGTH = 2..72

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable

  validates :email, presence: true, uniqueness: true, format: Devise::email_regexp
  validates :password, confirmation: true, length: { within: PASSWORD_LENGTH }, presence: true, on: :create

  validates :first_name, presence: true, length: { within: NAME_LENGTH }
  validates :last_name, presence: true, length: { within: NAME_LENGTH }

  belongs_to :team

  has_many :access_tokens

  # Contacts

  def full_name
    if first_name
      if last_name
        "#{first_name} #{last_name}"
      else
        first_name
      end
    else
      "Member"
    end
  end

  def invited_user?
    confirmation_token.present?
  end

  def email_required?
    confirmation_token.blank?
  end

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil? || confirmation_token.blank?
  end
end
