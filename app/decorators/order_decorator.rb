class OrderDecorator < Draper::Decorator
  delegate_all

  def state
    if object.paid?
      h.content_tag :span, 'Paid', class: 'label label-success'
    else
      h.content_tag :span, 'Pending', class: 'label label-danger'
    end
  end

  def created_on
    object.created_on.to_s(:weekday_long)
  end

  def today
    if object.created_on == Date.current
      h.content_tag :span, "Today's", class: 'label label-primary'
    end
  end
end
