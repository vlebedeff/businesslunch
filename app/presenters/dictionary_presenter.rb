class DictionaryPresenter
  def initialize(policy, collection)
    @policy = policy
    @collection = collection
  end

  def as_dictionary
    dictionary = {}

    @collection.each do |item|
      key = @policy.key_for(item)
      (dictionary[key] ||= []) << item
    end

    dictionary.sort.reverse.to_h
  end
end
