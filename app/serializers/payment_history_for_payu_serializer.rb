# PaymentHistory Serializer
class PaymentHistoryForPayuSerializer < ActiveModel::Serializer
  attributes :id, :name, :payment_date, :payment_type, :mobile_number, :plan,
             :pack, :start_date, :end_date, :transaction_id, :amount

  def transaction_id
    object.order_id
  end

  def payment_date
    object.created_at.strftime('%d %b %Y')
  end

  def payment_type
    if object.payment_type.to_i.zero?
      'Cash On Delivery'
    else
      'Online Payment'
    end
  end

  def name
    object.subscription.mobile_user.full_name
  end

  def mobile_number
    object.subscription.mobile_user.mobile_number
  end

  def plan
    plan = object.subscription.plan
    if plan.days == 5
      'Weekly'
    else
      'Monthly'
    end
  end

  def pack
    object.subscription.plan.pack.name.gsub('PACK', '').chomp.strip
  end

  def start_date
    object.starts_date.strftime('%d %b %Y')
  end

  def end_date
    object.ends_date.strftime('%d %b %Y')
  end

  def amount
    object.subscription.plan.price
  end
end
