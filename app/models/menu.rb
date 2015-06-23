class Menu
  include Virtus.model

  include ActiveModel::Model
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :available_on, Date
  attribute :menu_sets, Array[MenuSet]

  validates :available_on, presence: true

  def self.from_params(params)
    available_on = [
      params["available_on(1i)"],
      params["available_on(2i)"],
      params["available_on(3i)"]
    ].compact.join('-')

    menu_sets = params["menu_set"].map do |index, attrs|
      MenuSet.new attrs.permit(:name, :details)
    end

    new(
      available_on: available_on,
      menu_sets: menu_sets
    )
  end

  def persisted?
    false
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  private
  def persist!
    menu_sets.each { |ms| ms.available_on = available_on }.each(&:save)
  end
end
