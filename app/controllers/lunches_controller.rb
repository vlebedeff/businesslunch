class LunchesController < ApplicationController
  authorize_resource class: false

  def ready
    emails = User.has_order.pluck(:email)
    NotificationMailer.lunch_ready(emails).deliver if emails.present?
    redirect_to dashboard_path, notice: 'Notification has been sent.'
  end
end
