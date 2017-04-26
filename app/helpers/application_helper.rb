# Application Helper
module ApplicationHelper
  def is_active?(is_active)
    case is_active
    when true
      'Active'
    else
      'Inactive'
    end
  end

  def model_index(index)
    (@page.to_i - 1) * @per_page + index + 1
  end

  def truncate_html(string, length: 50)
    string = string.html_safe
    truncate(strip_tags(string), length: length)
  end

  def active?(location)
    (controller.controller_name == location) ? 'active' : ''
  end

  def show_date(date)
    date.strftime('%d %b %Y')
  end

  def show_date_time(datetime)
    datetime.strftime('%e %b %Y %l:%M%p')
  end

  def show_dates(dates)
    formated_dates = []
    dates.each { |date| formated_dates << show_date(date) } if dates.present?
    formated_dates.join(', ')
  end

  def customer_address(customer)
    [customer.address.flat_no, customer.address.wing.name,
     customer.address.society.name].join(', ')
  end

  def subscription_status(subscriptions)
    return 'Inactive' unless subscriptions.present?
    return 'Expired' unless subscriptions.active.present?
    inactive = []
    active = []
    subscriptions.active.each do |subscription|
      (subscription.start_at > Date.current) ? (inactive << subscription.id) : (
        active << subscription.id)
    end
    active_inactive_status(active, inactive)
  end

  def active_inactive_status(active, inactive)
    if inactive.present? && active.present?
      return 'Active'
    elsif inactive.present? && !active.present?
      return 'Inactive'
    else
      return 'Active'
    end
  end

  def customer_wing_society(customer)
    address = customer.address
    [
      address.flat_no, address.wing.name, address.society.name
    ].join('/')
  end

  def customer_area(customer)
    [customer.address.locality.name, customer.address.area.name].join('/')
  end

  def customer_online_ofline_status(customer)
    return 'Offline' if customer.authentications.empty?
    'Online'
  end

  def error_span_text(order, field)
    text = ''
    order.errors[field].each do |error|
      text << content_tag(:p, "#{field.to_s.humanize} #{error}", class: "alert alert-danger")
    end
    text.html_safe
  end
end
