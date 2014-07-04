class NotificationMailer < ActionMailer::Base
  default from: 'no-reply@businesslunch.herokuapp.com'

  def lunch_ready(user, menu_set)
    @menu_set = menu_set
    @user = user
    mail to: @user.email, subject: 'Neam-neam is here'
  end
end
