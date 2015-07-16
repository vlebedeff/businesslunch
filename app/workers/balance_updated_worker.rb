class BalanceUpdatedWorker
  include Sidekiq::Worker

  def perform(user_id, amount, currency_unit)
    user = User.find user_id
    NotificationMailer.balance_updated(user, amount, currency_unit).deliver_now
  end
end
