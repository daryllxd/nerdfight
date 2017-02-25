module HandleWrongParams
  extend ActiveSupport::Concern

  included do
    rescue_from Errors::WrongParamsError, with: :render_wrong_params
  end

  def render_wrong_params(wew)
    render json: { error: "Wrong key '#{wew}'." }, status: 400 and return
  end
end

