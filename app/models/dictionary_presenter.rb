class DictionaryPresenter
  def initialize(collection)
    @collection = collection
  end

  def as_dictionary
    dictionary = {}

    @collection.each do |item|
      key = item.created_at.to_date.to_s
      if dictionary.has_key? key
        dictionary[key] << item
      else
        dictionary[key] = [item]
      end
    end

    dictionary
  end
end
