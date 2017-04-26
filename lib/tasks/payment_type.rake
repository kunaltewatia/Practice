namespace :payment_history do
  desc 'previous payment history payment status mark as COD'
  task update_payment_type: :environment do
    PaymentHistory.where(payment_type: nil)
      .update_all(payment_type: '0')
  end

  task update_price: :environment do
    PaymentHistory.where(price: nil).each do |ph|
      ph.price = ph.subscription.plan.price
      ph.pack_name = ph.subscription.plan.pack.name
      ph.save
    end
  end

  task update_order_id: :environment do
    PaymentHistory.where(order_id: nil).each do |ph|
      pay_order_id = ph.response[:mihpayid].to_s if ph.response
      time = Time.now.strftime("%d%m%Y-%H%M%S")
      pay_order_id = "#{ph.subscription.mobile_user_id}-#{time}" if pay_order_id.blank?
      ph.order_id = 'F-' + pay_order_id
      ph.save!
    end
  end

  task update_orders: :environment do
    Order.where(status: 'Completed').update_all(is_paid: true)
  end
end
