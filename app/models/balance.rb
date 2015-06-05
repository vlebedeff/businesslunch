class Balance
  include Virtus.model
  include ActiveModel::Model

  attribute :user, User
  attribute :amount, Integer, default: 0
  attribute :manager, User

  validates :user, :manager, presence: true
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
    Activity.create user: manager, subject: user, action: 'balance_update',
                    data: amount
  end
end
