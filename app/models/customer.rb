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

# Mobile app user :: Customer
class Customer < MobileUser
  scope :with_search, lambda { |search|
    joins(address: :wing).where(
      "mobile_users.first_name LIKE ? OR mobile_users.last_name LIKE ? OR \
      mobile_users.mobile_number LIKE ? OR wings.name LIKE ? OR \
      addresses.flat_no  LIKE ?",
      "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"
    ) if search.present?
  }

  scope :with_type, lambda { |type|
    return unless type.present?
    case type
    when 'Verified'
      where(is_verified:  true)
    when 'Unverified'
      joins(:authentications).where(is_verified: false)
    when 'Offline'
      includes(:authentications).where(
        authentications: { mobile_user_id: nil })
    end
  }

  scope :with_subs_status, lambda { |subs_status|
    return unless subs_status.present?
    case subs_status
    when 'Active'
      joins(:subscriptions).where(
        'start_at <= ? and ends_at >= ?', Date.current, Date.current)
    when 'Inactive'
      cust_active_subs = joins(:subscriptions).where(
        'start_at <= ? and ends_at >= ?', Date.current, Date.current).pluck(:id)
      cust_future_subs = joins(:subscriptions).where(
        'start_at > ?', Date.current).pluck(:id)
      cust = cust_future_subs - cust_active_subs
      no_subs = Customer.includes(:subscriptions).where(
        subscriptions: { mobile_user_id: nil })
      result = cust + no_subs
      Customer.where(id: result.uniq)
    when 'Expired'
      active = Subscription.active.pluck(:mobile_user_id).uniq
      inactive = Subscription.inactive.pluck(:mobile_user_id).uniq
      result = inactive - active
      Customer.where(id: result.uniq)
    end
  }

  scope :with_pay_status, lambda { |pay_status|
    p_customers = []
    Customer.all.each do |customer|
      count = customer.subscriptions.joins(
        "LEFT OUTER JOIN payment_histories ON subscriptions.id = \
        payment_histories.subscription_id").where(
          "payment_histories.is_paid = ?", false).count
      p_customers << customer.id if count == 0
    end
    case pay_status
    when 'Paid'
      Customer.where(id: p_customers)
    when 'Unpaid'
      Customer.where.not(id: p_customers)
    end
  }

  scope :with_area, lambda { |f_area|
    joins(:address).where('addresses.area_id = ?', f_area) if
     f_area.present?
  }

  scope :with_locality, lambda { |f_locality|
    joins(:address).where('addresses.locality_id = ?', f_locality) if
    f_locality.present?
  }

  scope :with_society, lambda { |f_society|
    joins(:address).where('addresses.society_id = ?', f_society) if
    f_society.present?
  }

  scope :with_wing, lambda { |f_wing|
    joins(:address).where('wing_id = ?', f_wing) if f_wing.present?
  }

  def self.search(q)
    with_search(q[:f_search]).with_type(
      q[:type]).with_subs_status(q[:subs_status]).with_pay_status(
        q[:pay_status]).with_area(q[:f_area]).with_locality(
          q[:f_locality]).with_society(q[:f_society]).uniq
  end
end
