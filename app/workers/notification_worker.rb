class NotificationWorker
  include Sidekiq::Worker

  def perform(user_id, menu_set_id)
    user = User.find user_id
    menu_set = MenuSet.find menu_set_id
    NotificationMailer.lunch_ready(user, menu_set).deliver_now
    PushNotification.lunch_ready(user)
  end
end
