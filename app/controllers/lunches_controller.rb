class LunchesController < ApplicationController
  authorize_resource class: false

  def ready
    Order.today.find_each do |order|
      NotificationWorker.perform_async order.user_id, order.menu_set_id
    end
    redirect_to dashboard_path, notice: 'Notification has been sent.'
  end
end
