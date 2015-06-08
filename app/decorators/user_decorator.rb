class UserDecorator < Draper::Decorator
  delegate_all

  LUNCH_PRICE = 35

  def balance
    span_class = object.balance >= LUNCH_PRICE ? 'text-success' : 'text-danger'
    content = "Balance: #{object.balance} Lei"

    h.content_tag(:span, content, class: span_class)
  end

  def full_name
    object.email.split('@').first.split('.').map(&:capitalize).join(' ')
  end
end
