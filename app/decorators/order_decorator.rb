class OrderDecorator < Draper::Decorator
  delegate_all

  def state
    if object.paid?
      h.content_tag :span, 'Paid', class: 'label label-success'
    else
      h.content_tag :span, 'Pending Payment', class: 'label label-danger'
    end
  end

  def created_on
    object.created_on.to_s(:weekday_long)
  end
end
