class OrderMailer < ApplicationMailer
  include SendGrid
  default from: 'admin@marvelfresh.com'
  sendgrid_category 'frools'

  def notify(order)
    @order = order
    mail(to: 'admin@marvelfresh.com',
         bcc: ['omkar.ghate@weboniselab.com', 'nayan@weboniselab.com'],
         subject: "Mango Order Receive")
  end

  def notify_daily
    @orders = Order.where(delivery_date: Date.today + 1.days, status: ['Completed', 'Pending'])
    mail(to: 'admin@marvelfresh.com',
         bcc: ['omkar.ghate@weboniselab.com', 'nayan@weboniselab.com'],
         subject: "Mango Daily Orders")
  end
end
