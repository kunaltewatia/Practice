# metheds of mobile user controller
module ReminderModule
  private

  def renew_message(date, subs)
    case date
    when Date.current
      msg = renew_today
    when Date.current + 1.days
      msg = renew_1_day_after
    when Date.current + 2.days
      msg = renew_2_day_after(subs)
    end
    msg
  end

  def renew_today
    'Hurry!! Your subscription with Frools ends today. Please renew to avoid ' +
      'disruption of service'
  end

  def renew_1_day_after
    'Your subscription with Frools is about to end tomorrow. Please renew to ' +
    'avoid disruption of service'
  end

  def renew_2_day_after(subs)
    "Your subscription with Frools is about to end on #{subs.ends_at}. Please " +
    'renew to avoid disruption of service'
  end

  def pause_start_message
    'Your subscription is scheduled to be paused starting tomorrow. If you ' +
    'wish to continue receiving fresh fruits, please un-pause your ' +
    'subscription now!'
  end

  def pause_stop_message
    'Your subscription is scheduled to resume starting tomorrow. enjoy fresh ' +
    'fruits'
  end

  def bonus_pack_message
    'Hurray! The contact you shared with us has now joined Frools ' +
    'successfully. We are sending a BONUS PACK to you today for referring ' +
    'new user to us. Ask more of your friends and family to subscribe and ' +
    'earn more rewards.'
  end

  def save_notification(options, subs, type = nil)
    Notification.create(
      title: options[:notification][:title],
      body: options[:notification][:body],
      actions: options[:notification][:actions],
      payload: options[:notification][:payload],
      _type: type,
      subscription_id: subs.id,
      mobile_user_id: subs.mobile_user.id
    )
  end

  def renew_actions
    actions = []
    action = { icon: 'www/img/renew.png', title: 'Renew', callback: 'renew' }
    actions << action
    actions
  end

  def pause_payload(subs)
    serializer = CustomerSubscriptionSerializer.new(subs)
    JSON.parse(serializer.to_json)
  end

  def pause_stop_actions
    actions = []
    action = { icon: 'www/img/edit.png', title: 'Edit Pause Dates',
               callback: 'pause' }
    actions << action
    actions
  end

  def pause_start_actions
    actions = []
    action = { icon: 'www/img/edit.png', title: 'Edit Pause Dates',
               callback: 'pause' }
    actions << action
    actions
  end

  def create_options(title, msg, actions, preload, image, type = nil)
    {
      priority: 'high', collapse_key: type,
      notification: {
        title: title, body: msg, actions: actions, payload: preload,
        image: image, style: 'inbox', priority: 2, ledColor: [0, 0, 255, 0]
      }
    }
  end

  def send_notification_android(reg_ids, options)
    return if reg_ids.blank?
    gcm = GCM.new(Settings.gcm_api_key)
    gcm.send(reg_ids, options)
  end

  def send_notification_ios(reg_ids, options)
    return if reg_ids.blank?
    reg_ids.each do |reg_id|
      notification = Houston::Notification.new(device: reg_id)
      notification.alert = options[:notification][:body]
      notification.badge = 1
      notification.sound = 'default'
      # notification.custom_data = options.notification
      APN.push(notification)
    end
  end
end
