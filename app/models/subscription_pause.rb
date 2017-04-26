# SubscriptionPause
class SubscriptionPause < ActiveRecord::Base
  belongs_to :subscription
  belongs_to :mobile_user
  belongs_to :payment_history

  validates :mobile_user_id, :subscription_id, presence: true
  validates_uniqueness_of :date, scope: :subscription_id
  validate :past_date?

  scope :system_pauses, (lambda do |subs_id|
    where('subscription_id = ? and is_natural = ?', subs_id, false)
  end)

  scope :pause_dates, (lambda do |subs_id|
    where('subscription_id = ? and is_natural = ?', subs_id, true)
  end)

  scope :next_pauses, (lambda do
    where('date > ? and is_natural = ?', Date.current, true)
  end)

  def past_date?
    errors.add(:date, "can't be in the past or today") if
      !date.blank? && date <= Date.current
  end
end
