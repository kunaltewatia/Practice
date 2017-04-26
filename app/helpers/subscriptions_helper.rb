# SubscriptionsHelper
module SubscriptionsHelper
  def pay_status(i)
    case i
    when false
      'Unpaid'
    when true
      'Paid'
    end
  end

  def update_link(pay_history)
    if pay_history.is_paid
      link_to 'Update', edit_payment_history_path(id: pay_history.id),
              data: { toggle: 'modal', target: '#pay_status_modal' },
              remote: true, class: 'btn btn-default', disabled: true
    else
      link_to 'Update', edit_payment_history_path(id: pay_history.id),
              data: { toggle: 'modal', target: '#pay_status_modal' },
              remote: true, class: 'btn btn-default'
    end
  end
end
