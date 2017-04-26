# Custom Notification
class CustomNotification < ActiveRecord::Base
  include SmsGateway
  include ReminderModule
  after_save :notified

  validates :message, presence: true

  def notified
    if status.to_i.zero?
      users = MobileUser.all
    elsif status.to_i == 1
      users = MobileUser.verified
    else
      users = MobileUser.unverified
    end
    send_message(users) if is_sms
    send_notifications(users) if is_notification
  end

  private

  def send_message(users)
    users.each do |user|
      send_sms mobile_number: user.mobile_number, message: message
    end
  end

  def send_notifications(users)
    users.each { |user| send_notification(user) }
  end

  def send_notification(user)
    return if user.subscriptions.blank?
    options = create_options('Frools ', message, [], {},
                             'www/img/custom.png', 'custom')
    notification = save_notification(options, user.subscriptions.last,
                                     'custom')
    options[:notification][:notId] = notification.id
    SendNotification.send(user, options)
  end
end
