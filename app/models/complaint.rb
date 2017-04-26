require 'gcm'
# Complaint
class Complaint < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  scope :opened, -> { where(is_resolved: false, is_extra_fruit: false) }
  scope :closed, -> { where(is_resolved: true) }
  scope :accepted, -> { where(is_resolved: false, is_extra_fruit: true) }
  has_many :deliveries
  #belongs_to :mobile_user
  belongs_to :user
  belongs_to :complaint_category
  belongs_to :order

  validate :order?

  def listing_parameters
    { date: created_at.to_date, category_name: complaint_category.name,
      type: 'C', image: image_url(:thumb), is_resolved: is_resolved, text: text,
      admin_comment: admin_comment, complaint_for_date: date,
      is_extra_fruit:  is_extra_fruit, delivery_date: delivery_date,
      fruit_name: fruit_name }
  end

  def set_delivery_date
    return unless is_extra_fruit
    self.delivery_date = updated_at.to_date
      .next_day.to_datetime if is_extra_fruit_changed?
  end

  def validate_date?
    errors.add(:date, 'should be present') && return if date.nil?
    errors.add(:date, 'should be last three days except Sunday') unless
      date.between?((Date.yesterday - 2.day), Date.current)
  end

  def resolved_notification
    return unless is_resolved_changed?
    gcm = GCM.new(Settings.gcm_api_key)
    registration_ids = mobile_user.authentications.map(&:devise_token).compact
    msg = complaint_resolved_msg
    options = { notification: {
      title: 'Complaint Resolved!', body: msg, image: 'www/img/Complaints.png' }
    }
    gcm.send(registration_ids, options)
  end

  private

  def complaint_resolved_msg
    "Happy to inform you about resolution of your complaint dated\
    #{created_at.to_date} about #{complaint_category.name}. If you are not\
    satisfied with our service, write us a feedback and we will get in touch\
    with you"
  end

  def order?
    order = Order.find_by_txt_id(self.txt_id)
    #self.errors.add(:order_id, "Id is not found") unless order
    self.errors.add(:order_id, "We couldn't find this Order ID in our database. Please check again and re-enter") unless order
  end
end
