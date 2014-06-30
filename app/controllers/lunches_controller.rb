class LunchesController < ApplicationController
  authorize_resource class: false

  def ready
    NotificationMailer.lunch_ready(User.has_order.pluck(:email)).deliver
    redirect_to dashboard_path, notice: 'Notification has been sent.'
  end
end
