class Balance
  include Virtus.model
  include ActiveModel::Model

  attribute :user, User
  attribute :amount, Integer, default: 0
  attribute :manager, User

  validates :user, :manager, presence: true
  validates :amount, presence: true, numericality: { only_integer: true }
  validate :ensure_user_balance_positive

  def update
    return false if invalid?
    deposit!
    true
  end

  private

  def deposit!
    user.balance += amount
    user.save!
    Activity.create user: manager, subject: user, action: 'balance_update',
                    data: amount
    BalanceUpdatedWorker.perform_async user.id, amount
  end

  def ensure_user_balance_positive
    return unless user && (user.balance + amount.to_i < 0)
    errors.add :amount, I18n.t('errors.balance.negative')
  end
end
