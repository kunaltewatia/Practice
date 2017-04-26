# invitation model
class Invitation < ActiveRecord::Base
  include SmsGateway
  validates :mobile_number, presence: true,
                            length: { minimum: 10, maximum: 10 },
                            numericality: { only_integer: true }

  after_save :send_invite_msg

  def send_invite_msg
    send_sms mobile_number: mobile_number, message: message
  end

  private

  def message
    SMS_GATEWAY_CONFIG[:invite_msg].sub(':invitation_url',
                                        Settings.invitation_url)
  end
end
