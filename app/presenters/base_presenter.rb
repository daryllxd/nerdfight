class BasePresenter
  def self.present_collection(collection_of_models)
    collection_of_models.map do |model|
      new(model: model).present
    end
  end

  attr_reader :model

  def initialize(model: NullModel.new)
    @model = model
  end

  def present
    raise "Must implement present if you are a presenter."
  end
end
