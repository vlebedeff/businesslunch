class ListPresenter
  def initialize(collection)
    @collection = collection
  end

  def as_collection
    @collection.map { |c| [c.name, c.details, c.id] }
  end
end
