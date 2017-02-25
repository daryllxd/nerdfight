module Errors
  class RecordNotUnique < StandardError
    attr_reader :original_exception

    def initialize(exception)
      @original_exception = exception
      super(readable_exception)
    end

    def readable_exception
      parsed_information = original_exception.cause.message.split("\n").last

      "Unique constraint violated -- #{parsed_information} Possibly a race condition?"
    end
  end
end
