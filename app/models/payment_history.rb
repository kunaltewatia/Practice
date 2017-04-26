# Payment History
class PaymentHistory < ActiveRecord::Base
  include ReminderModule
  serialize :response
  belongs_to :subscription
  has_many :subscription_pauses, dependent: :destroy

  scope :paid, -> { where(is_paid: true) }
  scope :unpaid, -> { where(is_paid: false) }

  before_create :set_start_date
  before_create :set_price
  before_create :set_pack_name
  after_create :set_order_id
  after_create :set_dates
  after_create :create_pauses
  before_update :send_notification
  before_destroy :update_ends_at

  def create_pauses
    return unless subscription_type == 'Renew'
    histories = subscription.payment_histories.order(created_at: :desc).limit(2)
    return unless histories.size == 2
    calculate_end_date(histories)
  end

  def set_dates
    return unless subscription_type == 'Renew'
    if subscription.plan.days == 5
      set_week_date
    elsif subscription.plan.days == 30
      set_month_date
    end
  end

  private

  def calculate_end_date(histories)
    start_date, end_date = find_start_and_end_date(histories)
    (start_date..end_date).each do |date|
      create_pause(date) if date.wday != 0
    end
    subscription.ends_at = histories.take(2).first.ends_date
    subscription.save!
  end

  def find_start_and_end_date(histories)
    start_date = histories.take(2).last.subscription.ends_at + 1.days
    end_date = histories.take(2).first.starts_date - 1.days
    [start_date, end_date]
  end

  def create_pause(date, is_natural = false)
    subscription_pause = SubscriptionPause.new(
      mobile_user_id: subscription.mobile_user_id,
      date: date, is_natural: is_natural,
      payment_history_id: id,
      subscription_id: subscription.id)
    subscription_pause.save!
  rescue => e
    logger.info "Error : #{e.inspect}"
  end

  def set_start_date
    self.starts_date += 1.day if starts_date.wday == 0
  end

  def set_week_date
    self.ends_date = starts_date
    self.ends_date = add_plan_days(ends_date)
    self.ends_date += 1.day if ends_date.wday == 0
    save!
  end

  def add_plan_days(ends_date)
    subscription.plan.days.to_i.times do
      if ends_date.wday == 0
        ends_date += 2.day
      else
        ends_date += 1.day
      end
    end
    ends_date
  end

  def set_month_date
    self.ends_date = set_end_date
    self.ends_date = ends_date - 1.days if ends_date.wday == 0
    save!
  end

  def set_end_date
    if subscription.month_end?(starts_date)
      ends_date = starts_date.next_month.end_of_month
    else
      ends_date = starts_date.next_month - 1.day
    end
    ends_date
  end

  def set_price
    self.price = self.subscription.plan.price if self.subscription
  end

  def set_pack_name
    self.pack_name = self.subscription.plan.pack.name if self.subscription
  end

  def set_order_id
    pay_order_id = self.response['mihpayid'].to_s if self.response
    time = Time.now.strftime("%d%m%Y-%H%M%S")
    pay_order_id = "#{self.subscription.mobile_user_id}-#{time}" if pay_order_id.blank?
    self.order_id = 'F-' + pay_order_id
    self.save!
  end

  def send_notification
    return if is_paid == false
    return if subscription.mobile_user.authentications.blank?
    return if payment_type.to_i != 0
    msg = payment_notification_message
    options = create_options('Payment Received', msg, [], {},
                             'www/img/Payement.png', 'received')
    notification = save_notification(options, subscription, 'received')
    options[:notification][:notId] = notification.id
    SendNotification.send(subscription.mobile_user, options)
  end

  def payment_notification_message
    "Hurray! Your payment of #{subscription.plan.price} towards" +
    " your subscription with Frools has been received successfully. " +
    "Enjoy fresh fruits!"
  end

  def update_ends_at
    if subscription.plan.days == 5
      remove_week_date
    elsif subscription.plan.days == 30
      remove_month_date
    end
  end

  def remove_week_date
    subs_ends_date = self.subscription.ends_at
    update_pauses_payment_history
    subs_ends_date = remove_plan_days(subs_ends_date)
    subs_ends_date = remove_pause_days(subs_ends_date)
    subs_ends_date -= 1.day if subs_ends_date.wday == 0
    subscription.update_column(:ends_at, subs_ends_date)
  end

  def remove_plan_days(ends_date)
    (subscription.plan.days.to_i + 1).times do
      if ends_date.wday == 1
        ends_date -= 2.day
      else
        ends_date -= 1.day
      end
    end
    ends_date
  end

  def remove_pause_days(ends_date)
    subscription_pauses.count.times do
      if ends_date.wday == 1
        ends_date -= 2.day
      else
        ends_date -= 1.day
      end
    end
    ends_date
  end

  def remove_month_date
  end

  def update_pauses_payment_history
    p_ids = subscription.payment_histories.pluck(:id)
    index = p_ids.find_index(id) - 1
    p_id = p_ids[index]
    subscription_pauses.update_all(payment_history_id: p_id)
  end
end
