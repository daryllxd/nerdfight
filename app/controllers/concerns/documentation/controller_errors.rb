module Documentation::ControllerErrors
  extend ActiveSupport::Concern

  included do
    swagger_model :Error do
      description 'Generic Error'
      property :error, :string, :required, 'The error message'
    end
  end
end
