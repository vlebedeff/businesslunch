module MailerMacros
  def total_emails_count
    deliveries.count
  end

  def last_email
    deliveries.last
  end

  def reset_email
    deliveries = []
  end

  private
  def deliveries
    ActionMailer::Base.deliveries
  end
end
