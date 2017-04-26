# metheds of Delivery controller
module OrderDeliveryModule
  include OrderDeliverySubModule

  private

  def add_area(area_id, sheet)
    # sheet = add_area_header(area_id, sheet)
    sheet = add_area_deliveries(area_id, sheet)
    sheet
  end

  def add_area_deliveries(area_id, sheet)
    deliveries = @orders.where(area_id: area_id)
    sheet = add_area_delivery_content(deliveries, sheet)
    sheet
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

  # def add_area_header(area_id, sheet)
  #   add_area = add_area.find(area_id)
  #   packs = stat_pack_data([], area_id)
  #   extra = add_area_extra_count(area_id)
  #   total = total_count(area_id)
  #   bonus = bonus_count(area_id)
  #   add_area_text = (
  #     [add_area.name, '', packs, extra, total, bonus] + [''] * 1).flatten
  #   sheet.add_row add_area_text, style: ([@bold_with_background] * 8)
  #   sheet
  # end

  def bonus_count(societies)
    deliveries = @orders.where(area_id: societies)
    count = 0
    deliveries.each do |d|
      count = pack_increment_count(d) if d.referral_id.present?
    end
    "Bonus: #{count}"
  end

  def add_area_extra_count(area_id)
    ids = @orders.where(area_id: area_id).pluck(:complaint_id).compact
    count = Complaint.where(id: ids, is_extra_fruit: true).count
    "Extra: #{count}"
  end

  def total_count(societies)
    count = 0
    @orders.each do |d|
      count += d.unit.to_i
    end
    "Total: #{count}"
  end

  def add_area_delivery_content(deliveries, sheet)
    deliveries.each_with_index do |delivery, index|
      content = delivery_content(delivery)
      if index.even?
        sheet.add_row content, style: ([@with_background_even] * 9)
      else
        sheet.add_row content, style: ([@with_background_odd] * 9)
      end
    end
    sheet
  end

  def due_date(delivery)
    delivery.subscription.ends_at <= delivery.date + 3.days
  end

  def flat_address(delivery)
    text = []
    text << delivery.address
    text << delivery.area.name
    text.join(', ')
  end

  def pack_name(delivery)
    name = delivery.plan_unit.humanize
    name
  end
end
