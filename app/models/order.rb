class Order < ActiveRecord::Base
  include SmsGateway
  include OrderModule
  include OrderPaymentCheckModule
  serialize :response

  belongs_to :product
  belongs_to :plan
  belongs_to :area

  has_many :complaints

  after_create :set_txt_id
  after_create :set_status
  after_create :set_unit
  before_create :set_order_data
  after_save :set_price

  validates :product, :plan, :area, :user_name, :address, presence: true
  validates :mobile_number, presence: true,
                            length: { minimum: 10, maximum: 10 },
                            numericality: { only_integer: true }

  def set_txt_id
    self.txt_id = "M-#{self.id}-#{DateTime.current.to_i}"
    save!
  end

  def set_status
    self.status = 'Started'
    save!
  end

  def set_unit
    self.unit = "1" if self.unit.blank?
    save!
  end

  def set_price
    if self.unit_changed? && self.product.is_discounted
      price, discount, text = self.calc_unit(self.plan, self.unit.to_i)
      self.update_column(:price, price.to_i)
      self.update_column(:discount, discount.to_i)
    elsif self.product.is_discounted == false
      price = self.plan.price.to_i * self.unit.to_i
      self.update_column(:price, price)
      self.update_column(:discount, 0)
    end
  end

  def set_order_data
    self.product_name = self.product.name
    self.plan_unit = self.plan.name
    self.plan_price = self.plan.price
    self.delivery_date = Time.zone.now.to_date.next
  end

  def send_notification
    return if status == 'Completed'
    message = "Hurray! Your Mangoes are on the way! Order ID #{self.txt_id}" +
      " Amount Rs.#{self.price} Download Receipt #{Settings.server_name}/" +
      "export.pdf?id=#{self.txt_id}"
    send_sms mobile_number: self.mobile_number, message: message
  end

  def send_notification_cod
    return if status == 'Completed'
    message = "Hurray! Your Mangoes are on the way! Order ID #{self.txt_id}" +
      " Amount to be paid Rs.#{self.price} Download Receipt #{Settings.server_name}/" +
      "export.pdf?id=#{self.txt_id}"
    send_sms mobile_number: self.mobile_number, message: message
    OrderMailer.notify(self).deliver_now
  end

  def send_notification_cod_paid
    return if status == 'Completed'
    message = "Thankyou for ordering Mangoes from FROOLS." +
      " Download Receipt: #{Settings.server_name}/" +
      "export.pdf?id=#{self.txt_id} We are eagerly waiting for your next order!"
    send_sms mobile_number: self.mobile_number, message: message
  end

  def self.refresh
    @orders = Order.where.not(status: 'Completed')
              .where(created_at: 1.days.ago..Time.now)
    @orders.each { |order| order.fetch_data }
  end

  def payment_str
    return 'Payment Online' if self.payment_type.blank?
    return 'Cash On Delivery' if self.payment_type == '1'
    return 'Payment Online' if self.payment_type == '2'
    return 'PayTM' if self.payment_type == '3'
  end

  def online?
    self.payment_type.blank? || self.payment_type == '2' || self.payment_type == '3'
  end

  def cod?
    self.payment_type == '1'
  end
end
