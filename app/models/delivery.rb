# Model Delivery
class Delivery < ActiveRecord::Base
  belongs_to :mobile_user
  belongs_to :pack
  belongs_to :plan
  belongs_to :country
  belongs_to :state
  belongs_to :city
  belongs_to :area
  belongs_to :locality
  belongs_to :society
  belongs_to :wing
  belongs_to :complaint
  belongs_to :subscription
  belongs_to :referral

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end

  def self.generate_referral_bonus(date)
    customers = find_referree(date)
    customers.each do |customer|
      if customer.subscriptions.deliverable(date.to_date).blank?
        create_delivery(customer.subscriptions.last, customer.address,
                        date, nil, customer.referrals.last.id)
      else
        update_delivery(customer, date)
      end
    end
  end

  def self.update_delivery(customer, date)
    delivery = customer.deliveries.where(
      date: date.to_date, subscription_id: customer.subscriptions.deliverable(
        date.to_date).last.id).last
    delivery.update(referral_id: customer.referrals.last.id) if delivery
  end

  def self.find_referree(date)
    q_date = date == 1 ? date - 2.days : date - 1.day
    referrees = Referral.where('updated_at > ? and is_converted = ?',
                               q_date, true).pluck(:mobile_user_id)
    Customer.includes(
      :authentications, :referrals, :address, subscriptions: [plan: :pack])
      .where(id: referrees.uniq)
  end

  def self.generate(date = Time.zone.now)
    return if date.wday.zero?
    logger.debug '>>>>>>>>>>>>>>>>>>>>> Delivery Generate >>>>>>>>>>>>>>>>>>>>>'
    logger.debug ">>>>>>>>>>>>>> Start Time: #{Time.zone.now} >>>>>>>>>>>>>>>>>"
    subscriptions = find_active_subscription(date.to_date).compact
    generate_delivery(subscriptions, date.to_date)
    generate_referral_bonus(date)
    logger.debug ">>>>>>>>>>>>>> Stop Time: #{Time.zone.now} >>>>>>>>>>>>>>>>>"
  end

  def self.find_active_subscription(date)
    subscription = Subscription.includes(
      :subscription_pauses, mobile_user: [:address, :complaints], plan: [:pack]
    ).deliverable(date)
    subscription.collect do |s|
      s if s.subscription_pauses.where(date: date).count.zero?
    end
  end

  def self.generate_delivery(subscriptions, date)
    subscriptions.each do |sub|
      address = sub.mobile_user.address
      complaint_id = find_complaint(sub.mobile_user, date)
      create_delivery(sub, address, date, complaint_id)
    end
  end

  def self.create_delivery(sub, address, date, complaint_id = nil, ref_id = nil)
    Delivery.new(
      mobile_user_id: sub.mobile_user_id, pack_id: sub.plan.pack_id,
      plan_id: sub.plan_id, country_id: address.country_id,
      state_id: address.state_id, city_id: address.city_id,
      area_id: address.area_id, locality_id: address.locality_id,
      society_id: address.society_id, wing_id: address.wing_id,
      flat_no: address.flat_no, date: date, complaint_id: complaint_id,
      subscription_id: sub.id, referral_id: ref_id
    ).save!
  end

  def self.find_complaint(mobile_user, date)
    complaint = mobile_user.complaints.where(delivery_date: date)
    complaint.last.id if complaint.present?
  end
end
