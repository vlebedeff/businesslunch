class ListPresenter
  def initialize(collection)
    @collection = collection
  end

  def as_collection
    @collection.map { |c| [c.name, c.id] }
  end
end
