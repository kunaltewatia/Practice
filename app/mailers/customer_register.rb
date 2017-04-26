# CustomerRegisterNotification
class CustomerRegister < ActionMailer::Base
  include SendGrid
  default from: 'admin@marvelfresh.com'
  sendgrid_category 'frools'

  def notify(customers, subscriptions)
    @customers = customers
    @subscriptions = subscriptions
    mail(to: 'admin@marvelfresh.com',
         bcc: ['omkar.ghate@weboniselab.com', 'nayan@weboniselab.com'],
         subject: "#{Date.current.strftime('%d %b %Y')} Statistics")
  end
end
