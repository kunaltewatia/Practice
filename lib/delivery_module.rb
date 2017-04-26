# metheds of Delivery controller
module DeliveryModule
  include DeliverySubModule

  private

  def add_society(society_id, sheet)
    sheet = society_header(society_id, sheet)
    sheet = society_deliveries(society_id, sheet)
    sheet
  end

  def society_deliveries(society_id, sheet)
    wings = @deliveries.where(society_id: society_id).pluck(:wing_id).uniq.sort
    wings.each do |wing_id|
      deliveries = @deliveries.where(society_id: society_id, wing_id: wing_id)
      deliveries = deliveries.sort { |a, b| b.flat_no.to_i <=> a.flat_no.to_i }
      sheet = society_delivery_content(deliveries, sheet)
    end
    sheet.add_row []
    sheet
  end

  def end_date(delivery)
    delivery.subscription.ends_at.strftime('%d %b %Y') if delivery.subscription
  end

  def add_comment(delivery)
    comment = []
    comment << 'Add Extra Fruit' if delivery.complaint &&
                                    delivery.complaint.is_extra_fruit
    date_3 = Date.current + 3.days
    comment << 'Payment Reminder' if delivery.subscription &&
                                     delivery.subscription.ends_at < date_3
    comment.join(', ')
  end

  def add_header(sheet)
    sheet.add_row ['Wing', 'Flat No.', 'Name', 'Contact', 'Pack',
                   'End Date', 'Comment'] + ['']
    sheet.flatten
  end

  def society_header(society_id, sheet)
    society = Society.find(society_id)
    packs = stat_pack_data([], society_id)
    extra = society_extra_count(society_id)
    total = total_count(society_id)
    bonus = bonus_count(society_id)
    society_text = (
      [society.name, '', packs, extra, total, bonus] + [''] * 1).flatten
    sheet.add_row society_text, style: ([@bold_with_background] * 8)
    sheet
  end

  def bonus_count(societies)
    deliveries = @deliveries.where(society_id: societies)
    count = 0
    deliveries.each do |d|
      count = pack_increment_count(d) if d.referral_id.present?
    end
    "Bonus: #{count}"
  end

  def society_extra_count(society_id)
    ids = @deliveries.where(society_id: society_id).pluck(:complaint_id).compact
    count = Complaint.where(id: ids, is_extra_fruit: true).count
    "Extra: #{count}"
  end

  def total_count(societies)
    deliveries = @deliveries.where(society_id: societies)
    count = deliveries.pluck(:referral_id).count
    deliveries.each do |d|
      count += pack_increment_count(d) if
        d.referral_id.present? && d.subscription.is_active == true
    end
    "Total: #{count}"
  end

  def society_delivery_content(deliveries, sheet)
    deliveries.each_with_index do |delivery, index|
      content = delivery_content(delivery)
      if index.even?
        sheet.add_row content, style: ([@with_background_even] * 8)
      else
        sheet.add_row content, style: ([@with_background_odd] * 8)
      end
    end
    sheet
  end

  def highlight_delivery(delivery)
    text = []
    text = bonus_extra_flags(text, delivery)
    text << "Rs. #{delivery.subscription.plan.price}" if due_date(delivery)
    text << 'Special' if delivery.mobile_user.exceptions.present?
    text.join('/ ')
  end

  def bonus_extra_flags(text, delivery)
    text << 'Bonus' if delivery.referral
    text << 'Extra' if delivery.complaint && delivery.complaint.is_extra_fruit
    text
  end

  def due_date(delivery)
    delivery.subscription.ends_at <= delivery.date + 3.days
  end

  def flat_address(delivery)
    text = []
    text << delivery.wing.name
    text << delivery.flat_no
    text.join('/')
  end

  def pack_name(delivery)
    name = delivery.pack.name.split(' ').first.humanize
    if delivery.subscription.ends_at > Date.current && delivery.referral
      count = delivery.mobile_user.referrals.where(
        'updated_at > ? and is_converted = ?',
        delivery.date.to_time - 1.day, true
      ).count
      name << ": #{count + 1}"
    end
    name
  end
end
