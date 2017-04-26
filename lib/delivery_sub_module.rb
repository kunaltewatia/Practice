# delivery sub module
module DeliverySubModule
  private

  def remark(delivery)
    text = []
    text = remark_bonus(text, delivery)
    text << 'Collect Payment' if due_date(delivery)
    text << exceptions(delivery) if delivery.mobile_user.exceptions.present?
    text << replacement_fruit(delivery.complaint) if delivery.complaint
    text.join(', ')
  end

  def remark_bonus(text, delivery)
    if delivery.referral
      text << 'Bonus For Referrals'
      ref = delivery.mobile_user.referrals.where(
        'updated_at > ? and is_converted = ?',
        delivery.date.to_time - 1.day, true)
      text << ref.pluck(:contact).join(', ')
    end
    text
  end

  def name(delivery)
    return unless delivery
    delivery.mobile_user.full_name.humanize
  end

  def contact(delivery)
    return unless delivery
    delivery.mobile_user.mobile_number
  end

  def exceptions(delivery)
    return unless delivery
    delivery.mobile_user.exceptions
  end

  def notes(delivery)
    return unless delivery
    delivery.mobile_user.notes
  end

  def replacement_fruit(complaint)
    "Replacement: #{complaint.fruit_name}" if complaint &&
                                              complaint.is_extra_fruit
  end

  def delivery_content(delivery)
    content = [
      highlight_delivery(delivery), flat_address(delivery),
      pack_name(delivery), remark(delivery), name(delivery),
      contact(delivery), end_date(delivery), notes(delivery)
    ]
    content
  end

  def create_excel_data(p, societies)
    workbook = p.workbook
    workbook = workbook_style(workbook)
    workbook.add_worksheet(name: 'Basic Worksheet') do |sheet|
      sheet = add_statistics(societies, sheet)
      heading = excel_heading
      sheet.add_row heading.flatten, style: ([@with_background_even] * 8)
      sheet = societies.each { |s| add_society(s, sheet) }
    end
    p.use_shared_strings = true
    p
  end

  def workbook_style(workbook)
    left = { horizontal: :left }
    @with_background_even = workbook.styles.add_style bg_color: 'FFFFFF',
                                                      alignment: left
    @with_background_odd = workbook.styles.add_style bg_color: 'F2F2F2',
                                                     alignment: left
    @bold_with_background = workbook.styles.add_style bg_color: 'E2D3EB',
                                                      b: true, alignment: left
    workbook
  end

  def add_statistics(societies, sheet)
    extra = @deliveries.where(society_id: societies).pluck(:complaint_id)
            .compact.count
    total = total_count(societies)
    bonus = bonus_count(societies)
    packs = [down_date, '']
    packs = stat_pack_data(packs, societies)
    packs << "Extra: #{extra}" << "#{total}" << "#{bonus}" << ([''] * 1)
    sheet = set_header(packs.flatten, sheet)
    sheet
  end

  def set_header(packs, sheet)
    name = ([''] * 3) + ['MARVEL FRESH PRODUCE PVT. LTD.'] + ([''] * 4)
    sheet.add_row name, style: ([@bold_with_background] * 8)
    sheet.add_row []
    sheet.add_row packs, style: ([@bold_with_background] * 8)
    sheet.add_row []
    sheet
  end

  def stat_pack_data(packs, societies)
    Pack.active.each do |pack|
      deliveries = @deliveries.where(society_id: societies, pack_id: pack.id)
      count = deliveries.count
      deliveries.each do |d|
        count += pack_increment_count(d) if
          d.referral_id.present? && d.subscription.is_active == true
      end
      packs << "#{pack.name.split(' ').first.humanize}: #{count}"
    end
    packs
  end

  def pack_increment_count(delivery)
    count = delivery.mobile_user.referrals.where(
      'updated_at > ? and is_converted = ?',
      delivery.date.to_time - 1.day, true
    ).count
    count
  end

  def down_date
    if params[:q] && params[:q][:date_date_equals]
      Date.parse(params[:q][:date_date_equals]).strftime('%d %b %Y')
    else
      Date.current.strftime('%d %b %Y')
    end
  end

  def excel_heading
    heading = [
      'Highlight', 'Flat No.', 'Pack', 'Remark', 'Name', 'Contact No.',
      'Sub. End Date', 'Notes'
    ]
    heading
  end
end
