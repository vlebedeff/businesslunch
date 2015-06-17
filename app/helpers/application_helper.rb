module ApplicationHelper
  def formatted_date(date)
    Date.parse(date).to_s(:weekday_long) rescue date
  end

  def navbar_link_to(title, path, icon = '', prefix = true)
    content_tag :li, class: ('active' if current_page?(path)) do
      link_to(iconized_text(title, icon, prefix).html_safe, path)
    end
  end

  def iconized_text(text, icon, prefix = true)
    prefix ? "#{fa_icon(icon)} #{text}" : "#{text} #{fa_icon(icon)}"
  end

  def can_remove_order?(order)
    can?(:manage, order) && !Freeze.frozen? && order.created_on > Date.yesterday
  end

  def link_to_delete(object)
    link_to object, method: :delete, data: { confirm: t(:are_you_sure) }, class: 'btn btn-danger btn-sm', id: dom_id(object, :delete) do
      fa_icon 'trash'
    end
  end

  def link_to_payment(order, options = {})
    if order.pending?
      link_to 'Pay', pay_order_path(order),
        options.merge({ class: 'btn btn-success btn-sm', method: :patch })
    elsif order.paid?
      link_to 'Unpaid', cancel_payment_order_path(order),
        options.merge({ class: 'btn btn-danger btn-sm', method: :patch })
    end
  end

  def display_pay_from_balance_hint?
    last_order && current_user.can_pay_for?(last_order)
  end

  def link_to_pay_from_balance(title = t('balance.helpers.pay'), order)
    link_to title,
      pay_from_balance_order_path(order),
      class: 'btn btn-sm btn-success',
      method: :patch,
      data: { confirm: t('balance.pay_confirm') }
  end
end
