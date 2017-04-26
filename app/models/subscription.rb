# Subscription
class Subscription < ActiveRecord::Base
  include SmsGateway
  has_many :subscription_pauses, dependent: :destroy
  has_many :payment_histories, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :deliveries, dependent: :destroy
  belongs_to :plan
  belongs_to :mobile_user

  has_one_time_password length: 6

  validates :plan_id, :start_at, :payment_type, presence: true

  # after_create :send_otp
  before_create :set_start_at
  after_create :set_ends_at
  after_create :create_payment_history

  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) }
  scope :deliverable, (lambda do |date|
    where('start_at <= ? AND ends_at >= ?', date, date)
  end)

  def send_otp
    send_sms mobile_number: mobile_user.mobile_number,
             message: message unless mobile_user.is_verified?
  end

  def update_ends_at
    subscription_pauses.count.times do
      self.ends_at += 1.day
      self.ends_at += 1.day if ends_at.wday == 0
    end
    save!
  end

  def month_end?(date)
    date == date.end_of_month
  end

  def self.mark_inactive
    logger.debug '>>>>>>>>>>>>>>>>>>>>>>>>>>> Mark Inactive >>>>>>>>>>>>>>>>>'
    logger.debug ">>>>>>>>>>>>>> Start Time: #{Time.zone.now} >>>>>>>>>>>>>>>>>"
    Subscription.where('ends_at < ?', Time.zone.now.to_date)
      .update_all(is_active: false)
    logger.debug ">>>>>>>>>>>>>> End Time: #{Time.zone.now} >>>>>>>>>>>>>>>>>"
  end

  private

  def message
    SMS_GATEWAY_CONFIG[:otp_messages][:user_app].sub(':otp_code', otp_code)
  end

  def set_start_at
    self.start_at += 1.day if start_at.wday == 0
  end

  def set_ends_at
    if plan.days == 5
      set_week_date
    elsif plan.days == 30
      set_month_date
    end
  end

  def set_week_date
    self.ends_at = start_at
    self.ends_at = add_plan_days(ends_at)
    self.ends_at += 1.day if ends_at.wday == 0
    save!
  end

  def add_plan_days(ends_at)
    plan.days.to_i.times do
      if ends_at.wday == 0
        ends_at += 2.day
      else
        ends_at += 1.day
      end
    end
    ends_at
  end

  def set_month_date
    self.ends_at = calculate_end_date
    self.ends_at -= 1.day if ends_at.wday == 0
    save!
  end

  def calculate_end_date
    if month_end?(start_at)
      ends_at = start_at.next_month.end_of_month
    else
      ends_at = start_at.next_month - 1.day
    end
    ends_at
  end

  def create_payment_history
    payment_histories.create(starts_date: start_at, ends_date: ends_at,
                             is_active: true, subscription_type: 'New',
                             is_paid: payment_type.to_i,
                             payment_type: payment_type)
  end
end
