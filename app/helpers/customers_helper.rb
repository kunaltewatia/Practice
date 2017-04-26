# CustomersHelper
module CustomersHelper
  def options_for_payment_type
    options_for_select([['COD', 0]])
  end

  def renew_date(date)
    if date.wday == 6
      date += 2.day
    else
      date += 1.day
    end
    date
  end

  def end_date_param(date)
    days = date - Date.current
    days
  end

  def customer_type(customer)
    if customer.is_verified == true
      return 'Verified'
    elsif customer.is_verified == false && customer.authentications.empty?
      return 'Offline'
    else
      return 'Unverified'
    end
  end

  def payment_type(i)
    case i
    when '0'
      'COD'
    when '1'
      'ONLINE'
    end
  end

  def payment_status(i)
    case i
    when '0'
      'DUE'
    when '1'
      'DONE'
    end
  end

  def customer_pay_status(subscriptions)
    return 'None' unless subscriptions.present?
    if subscriptions.joins(:payment_histories).where(
      'payment_histories.is_paid = ?', false).present?
      return 'Unpaid'
    end
    'Paid'
  end

  def subscription_pay_status(subs)
    return 'None' unless subs.present?
    return 'Unpaid' if subs.payment_histories.where(is_paid: false).present?
    'Paid'
  end

  def status(subscription)
    if subscription.start_at > Date.current
      return 'Inactive'
    elsif subscription.ends_at < Date.current
      return 'Expired'
    else
      return 'Active'
    end
  end

  def customer_full_addr(customer)
    address = customer.address
    [
      address.flat_no, address.wing.name, address.society.name,
      address.locality.name, address.area.name, address.city.name
    ].join(', ')
  end

  def subscription_pack_name(subscription)
    ph_s = subscription.payment_histories
    ph_s.last.pack_name if ph_s.present?
  end
end
