class NotificationMailer < ActionMailer::Base
  default from: 'no-reply@businesslunch.herokuapp.com'

  def lunch_ready(emails)
    mail to: emails, subject: 'Neam-neam is here'
  end
end
