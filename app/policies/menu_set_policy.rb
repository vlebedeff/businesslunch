class MenuSetPolicy
  def key_for(object)
    object.available_on.to_s
  end
end
