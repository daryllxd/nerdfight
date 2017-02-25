module Users::Scopes
  extend ActiveSupport::Concern

  module ClassMethods
    def find_users_from(contacts: [])
      return [] unless is_array_of_hashes(contacts)

      list_of_emails = contacts.map { |contact| contact[:email] ? contact[:email].downcase : nil}

      existing_users = select("id, email, first_name, handicap_value, last_name, nickname, phone_number")
      .where(email: list_of_emails)
      .where.not(email: nil)
    end

    def find_users_and_non_registered_from(contacts: [])
      return [] unless is_array_of_hashes(contacts)

      found_users = find_users_from(contacts: contacts)

      contacts.map { |contact|
        found_user = found_users.find_by(email: contact[:email] ? contact[:email].downcase : false)

        found_user ? found_user : InvitedUser.new(user: contact)
      }
    end

    def is_array_of_hashes(collection)
      (collection.present? && collection.is_a?(Enumerable) && collection.first.respond_to?(:keys))
    end
  end
end
