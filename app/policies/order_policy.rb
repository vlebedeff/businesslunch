class OrderPolicy
  def key_for(object)
    object.created_at.to_date.to_s
  end
end
