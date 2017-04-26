require 'gcm'
# reminders worker
class ReminderWorker
  include ReminderModule
  # include Sidekiq::Worker

  def start
    renew_reminder
    pause_start_reminder
    pause_stop_reminder
  end

  def pause_start_reminder(date = Time.zone.now.to_date)
    return if date.wday.zero?
    Rails.logger.debug '>>>>>>>>>>>>>>>>> Pause Start Reminder >>>>>>>>>>>>>>>>>>>>>'
    Rails.logger.debug ">>>>>>>>>>>>>> Start Time: #{Time.zone.now} >>>>>>>>>>>>>>>>>"
    subscriptions = Subscription.deliverable(date)
    subscriptions.each do |subscription|
      if subscription.subscription_pauses.where(date: date).blank? &&
         subscription.subscription_pauses.where(date: date + 1.days).present?
        send_pause_start_notifications(subscription)
      end
    end
    Rails.logger.debug ">>>>>>>>>>>>>> End Time: #{Time.zone.now} >>>>>>>>>>>>>>>>>"
  end

  def pause_stop_reminder(date = Time.zone.now.to_date)
    return if date.wday.zero?
    Rails.logger.debug '>>>>>>>>>>>>>>>>> Pause Stop Reminder >>>>>>>>>>>>>>>>>>>>>'
    Rails.logger.debug ">>>>>>>>>>>>>> Start Time: #{Time.zone.now} >>>>>>>>>>>>>>>>>"
    subscriptions = Subscription.deliverable(date)
    subscriptions.each do |subscription|
      if subscription.subscription_pauses.where(date: date).present? &&
         subscription.subscription_pauses.where(date: date + 1.days).blank?
        send_pause_stop_notifications(subscription)
      end
    end
    Rails.logger.debug ">>>>>>>>>>>>>> End Time: #{DateTime.now} >>>>>>>>>>>>>>>>>"
  end

  def renew_reminder
    Rails.logger.debug '>>>>>>>>>>>>>>>>> Renew Reminder >>>>>>>>>>>>>>>>>>>>>'
    Rails.logger.debug ">>>>>>>>>>>>>> Start Time: #{Time.zone.now} >>>>>>>>>>>>>>>>>"
    date = Time.zone.now.to_date
    reminder(date + 2.days, REMINDER[0])
    reminder(date + 1.days, REMINDER[1])
    reminder(date, REMINDER[2])
    Rails.logger.debug ">>>>>>>>>>>>>> End Time: #{Time.zone.now} >>>>>>>>>>>>>>>>>"
  end

  def reminder(date = Date.current, reminder)
    config = Configuration.find_by_name(reminder)
    return unless config.is_active
    subscriptions = Subscription.includes(:mobile_user).where(ends_at: date)
    subscriptions.each do |subs|
      send_notification(date, subs)
    end
  end

  def send_notification(date, subs)
    return if subs.mobile_user.authentications.blank?
    msg = renew_message(date, subs)
    options = create_options('Renewal Reminder', msg,
                             renew_actions, pause_payload(subs),
                             'www/img/Subscription.png', 'renew')
    notification = save_notification(options, subs, 'renew')
    options[:notification][:notId] = notification.id
    SendNotification.send(subs.mobile_user, options)
  end

  def send_pause_start_notifications(subs)
    return if subs.mobile_user.authentications.blank?
    msg = pause_start_message
    options = create_options('Subscription Pause Reminder', msg,
                             pause_start_actions, pause_payload(subs),
                             'www/img/Pause.png', 'pause')
    notification = save_notification(options, subs, 'pause')
    options[:notification][:notId] = notification.id
    SendNotification.send(subs.mobile_user, options)
  end

  def send_pause_stop_notifications(subs)
    return if subs.mobile_user.authentications.blank?
    msg = pause_stop_message
    options = create_options('Subscription Resume Reminder', msg,
                             pause_stop_actions, pause_payload(subs),
                             'www/img/Resume.png', 'resume')
    notification = save_notification(options, subs, 'resume')
    options[:notification][:notId] = notification.id
    SendNotification.send(subs.mobile_user, options)
  end

  def send_bonus_notification(date = Time.zone.now)
    customers = Delivery.find_referree(date)
    return unless customers.present?
    msg = bonus_pack_message
    options = create_options(
      'Bonus Pack Notification', msg, nil, nil, nil, 'bonus')
    customers.each do |customer|
      next if customer.authentications.blank?
      notify_bonus(customer, options)
    end
  end

  def notify_bonus(customer, options)
    subs = customer.subscriptions.last
    notification = save_notification(options, subs, 'bonus')
    options[:notification][:notId] = notification.id
    SendNotification.send(subs.mobile_user, options)
  end
end
