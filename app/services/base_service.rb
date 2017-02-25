class BaseService
  include ActiveSupport::Rescuable

  rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid
  rescue_from ActiveRecord::RecordNotUnique, with: :handle_record_not_unique
  rescue_from ActiveRecord::AssociationTypeMismatch, with: :handle_record_invalid

  protected

  def handle_record_invalid(exception)
    raise Errors::RecordInvalidError.new(exception)
  end

  def handle_record_not_unique(exception)
    raise Errors::RecordNotUnique.new(exception)
  end

  # Populates hash
  # { first_name: attributes[first_name] }
  def build_edit_attributes
    edit_hash = {}

    editable_attributes.each do |attr|
      if attributes.key?(attr)
        edit_hash[attr] = attributes[attr]
      end
    end

    edit_hash
  end

  def ensure_no_excess_attributes(supplied_keys = attribute_keys, required_keys = editable_attributes)
    if excess_attributes = supplied_keys.find { |k| !required_keys.include?(k) }
      raise Errors::WrongParamsError, excess_attributes
    end
  end

  def attributes
    raise "Services must implement 'attributes', or use 'attributes' as a variable"
  end

  def attribute_keys
    attributes.keys.map { |k| k.to_sym }
  end

  def editable_attributes
    raise "Services must implement 'editable_attributes'"
  end
end
