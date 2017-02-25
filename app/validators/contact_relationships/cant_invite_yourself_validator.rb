class ContactRelationships::CantInviteYourselfValidator < ActiveModel::Validator
  def validate(record)
    # Cannot add yourself
    if record.sender_user_id == record.receiver_user_id
      record.errors.add(:base, "Cannot add yourself as a contact.")
    end
  end
end
