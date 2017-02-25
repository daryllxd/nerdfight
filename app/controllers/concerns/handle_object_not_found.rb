module HandleObjectNotFound
  extend ActiveSupport::Concern

  def ensure_found_all_from_params(finder_class, finder_value)
    raise Errors::ObjectNotFoundError.new(finder_value) unless params[finder_value].is_a?(Array)

    array_of_ids = params[finder_value].map { |elem| elem[:id] }

    finder_class.where(id: array_of_ids)
  end

  # Implied that if we are looking for a course using course_id, if we do not find course_id in the parameter list, then we won't find it--at least we report to the user that course_id is missing, not that we can't find a course using that course_id
  def ensure_found_object_from_params(finder_class, finder_value, finder_index='id')
    ensure_params_are_present(finder_value)
    found_object = finder_class.find_by(finder_index => params[finder_value])

    if found_object
      found_object
    else
      fail Errors::ObjectNotFoundError.new(finder_class)
    end
  end

  # "Cannot find course with that id."
  def render_not_found_if_object_not_found(params)
    render json: { error: "Cannot find #{params.to_s.tableize.singularize} with that id." }, status: 404 and return
  end


  included do
    rescue_from Errors::ObjectNotFoundError, with: :render_not_found_if_object_not_found
  end
end

