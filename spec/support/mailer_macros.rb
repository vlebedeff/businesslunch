module MailerMacros
  def total_emails_count(subject = 'Neam-neam is here')
    deliveries.select { |d| d.subject == subject }.count
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
