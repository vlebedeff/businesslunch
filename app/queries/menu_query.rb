class MenuQuery
  def initialize(relation = MenuSet.available)
    @relation = relation
  end

  def self.if_not_frozen
    new.if_not_frozen
  end

  def if_not_frozen
    Freeze.frozen? ? @relation.none : @relation
  end
end
