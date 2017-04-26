# == Schema Information
#
# Table name: mobile_users
#
#  id             :integer          not null, primary key
#  mobile_number  :string(255)
#  uuid           :string(255)
#  is_verified    :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  otp_secret_key :string(255)
#
class MobileUser < ActiveRecord::Base
  include SmsGateway

  scope :verified, -> { where(is_verified: true) }
  scope :unverified, -> { where(is_verified: false) }
  # after_create :send_otp
  has_one_time_password length: 6

  has_one :address, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :subscription_pauses, through: :subscriptions, dependent: :destroy
  has_many :deliveries, dependent: :destroy
  has_many :complaints, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_many :authentications, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :referrals, dependent: :destroy

  accepts_nested_attributes_for :address, allow_destroy: true

  accepts_nested_attributes_for :subscriptions, allow_destroy: true,
                                                reject_if: :all_blank
  validates :address, presence: true
  validates :mobile_number, presence: true,
                            length: { minimum: 10, maximum: 10 },
                            numericality: { only_integer: true }
  validates_uniqueness_of :mobile_number

  def full_name
    [first_name, last_name].join(' ')
  end

  def address_flat_society
    [address.flat_no, address.wing.name, address.society.name]
  end

  def address_area_city
    [address.locality.name, address.area.name, address.city.name]
  end

  def uuids
    authentications.pluck(:uuid).join(', ')
  end

  # Method from SmsGateway module
  def send_otp
    update_attribute(:otp_secret_key, ROTP::Base32.random_base32)
    send_sms mobile_number: mobile_number, message: message
  end

  def received_complaints
    feedback_complaints = complaints.order(created_at: :desc).collect { |i| i.listing_parameters }.concat(feedbacks.order(created_at: :desc).collect{ |i| i.listing_parameters })
  end

  def unsubscribed?
    subscriptions.count != 0
  end

  private

  def message
    SMS_GATEWAY_CONFIG[:otp_messages][:user_app].sub(':otp_code', otp_code)
  end
end
