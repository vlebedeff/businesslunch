class BalanceUpdatedWorker
  include Sidekiq::Worker

  def perform(user_id, amount)
    user = User.find user_id
    NotificationMailer.balance_updated(user, amount).deliver
  end
end
