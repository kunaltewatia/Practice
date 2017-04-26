# Referral
class Referral < ActiveRecord::Base
  include SmsGateway
  has_many :deliveries
  belongs_to :mobile_user
  belongs_to :referrer, class_name: 'MobileUser',
                        foreign_key: 'mobile_user_id'
  belongs_to :referent, class_name: 'MobileUser', foreign_key: 'referred_id'

  validates :mobile_user_id, presence: true
  validates :contact, presence: true,
                      length: { minimum: 10, maximum: 10 },
                      numericality: { only_integer: true }
  validates_uniqueness_of :contact, message: 'Oh no! The number you referred
  has either been referred by someone, or is already registered with us.
  Please refer a new user and get a bonus now!'

  scope :converted, -> { where(is_converted: true) }
  scope :waited, -> { where(is_converted: false) }

  after_create :send_ref_msg

  def send_ref_msg
    send_sms mobile_number: contact, message: message
  end

  private

  def message
    SMS_GATEWAY_CONFIG[:referral_msg]
  end
end
