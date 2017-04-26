# Wrapper class for sns and apns notifications
class SendNotification
  def self.send(mobile_user, options)
    send_sns(mobile_user, options)
    send_apns(mobile_user, options)
  end

  def self.send_sns(mobile_user, options)
    reg_ids = mobile_user.authentications.where(
      os: 'android').map(&:devise_token).compact
    return if reg_ids.blank?
    gcm = GCM.new(Settings.gcm_api_key)
    gcm.send(reg_ids, options)
  end

  def self.send_apns(mobile_user, options)
    reg_ids = mobile_user.authentications.where(
      os: 'ios').map(&:devise_token).compact
    return if reg_ids.blank?
    reg_ids.each do |reg_id|
      notification = Houston::Notification.new(device: reg_id)
      notification.alert = options[:notification][:body]
      notification.badge = mobile_user.notifications.where(is_viewed: false).count
      notification.sound = 'default'
      # notification.custom_data = options.notification
      APN.push(notification)
    end
  end
end
