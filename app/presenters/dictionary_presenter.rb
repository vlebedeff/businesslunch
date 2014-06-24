class DictionaryPresenter
  def initialize(policy, collection)
    @policy = policy
    @collection = collection
  end

  def as_dictionary
    dictionary = {}

    @collection.each do |item|
      key = @policy.key_for(item)
      if dictionary.has_key? key
        dictionary[key] << item
      else
        dictionary[key] = [item]
      end
    end

    dictionary
  end
end
