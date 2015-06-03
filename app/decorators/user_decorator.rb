class UserDecorator < Draper::Decorator
  delegate_all

  LUNCH_PRICE = 35

  def amount
    span_class = object.amount >= LUNCH_PRICE ? 'text-success' : 'text-danger'
    content = "Balance: #{object.amount} Lei"

    h.content_tag(:span, content, class: span_class)
  end

end
