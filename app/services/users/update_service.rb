class Users::UpdateService < BaseService
  attr_reader :user, :attributes

  def initialize(user:, attributes:)
    @user = user
    @attributes = attributes
  end

  def call
    ensure_no_excess_attributes

    begin
      user.update_attributes!(build_edit_attributes)
      return user
    rescue StandardError => exception
      rescue_with_handler(exception) || raise
    end
  end

  private

  def editable_attributes
    %i{first_name last_name}
  end
end
