class Balance
  include Virtus.model
  include ActiveModel::Model

  attribute :user, User
  attribute :amount, Integer, default: 0

  validates :user, presence: true
  validates :amount, presence: true, numericality: { only_integer: true }

  def update
    return false if invalid?
    deposit!
    true
  end

  private

  def deposit!
    user.amount += amount
    user.save!
  end
end
