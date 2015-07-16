class UserDecorator < Draper::Decorator
  delegate_all

  LUNCH_PRICE = 35

  def balance(prefix = '')
    span_class = object.balance >= LUNCH_PRICE ? 'text-success' : 'text-danger'
    content = "#{prefix}#{object.balance} #{object.current_group.try(:currency_unit)}"

    h.content_tag(:span, content, class: span_class)
  end

  def full_name
    object.email.split('@').first.split('.').map(&:capitalize).join(' ')
  end
end
