module HandleRecordInvalid
  extend ActiveSupport::Concern

  def render_record_invalid(active_record_error)
    render json: { error: active_record_error }, status: 400 and return
  end

  included do
    rescue_from Errors::RecordInvalidError, with: :render_record_invalid
  end
end
