# delivery sub module
module OrderDeliverySubModule
  private

  def name(delivery)
    return unless delivery
    delivery.user_name.humanize
  end

  def contact(delivery)
    return unless delivery
    delivery.mobile_number
  end

  def exceptions(delivery)
    return unless delivery
    delivery.mobile_user.exceptions
  end

  def replacement_fruit(complaint)
    "Replacement: #{complaint.fruit_name}" if complaint &&
                                              complaint.is_extra_fruit
  end

  def delivery_content(delivery)
    content = [
      delivery.txt_id, name(delivery), contact(delivery), delivery.product_name,
      delivery.unit, delivery.discount, delivery.price, flat_address(delivery),
      delivery.area.name
    ]
    content
  end

  def create_excel_data(p, areas)
    workbook = p.workbook
    workbook = workbook_style(workbook)
    workbook.add_worksheet(name: 'Basic Worksheet') do |sheet|
      sheet = add_statistics(areas, sheet)
      heading = excel_heading
      sheet.add_row heading.flatten, style: ([@bold_with_background] * 9)
      sheet = areas.each { |s| add_area(s, sheet) }
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

  def add_statistics(areas, sheet)
    total = total_count(areas)
    packs = [down_date, '']
    packs = stat_pack_data(packs, areas)
    packs << "Total: #{total}" << ([''] * 3)
    sheet = set_header(packs.flatten, sheet)
    sheet
  end

  def set_header(packs, sheet)
    name = ([''] * 3) + ['MARVEL FRESH PRODUCE PVT. LTD.'] + ([''] * 5)
    sheet.add_row name, style: ([@bold_with_background] * 9)
    sheet.add_row []
    sheet.add_row packs, style: ([@bold_with_background] * 9)
    sheet.add_row []
    sheet
  end

  def stat_pack_data(packs, areas)
    areas.each do |area|
      count = 0
      deliveries = @orders.where(area_id: area)
      area = Area.find(area)
      deliveries.each do |d|
        count += d.unit.to_i
      end
      packs << "#{area.name.humanize}: #{count}"
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
    if params[:q] && params[:q][:delivery_date_date_equals]
      Date.parse(params[:q][:delivery_date_date_equals]).strftime('%d %b %Y')
    else
      Date.current.next.strftime('%d %b %Y')
    end
  end

  def excel_heading
    heading = [
      'Order Id', 'Name', 'Mobile Number', 'Product Name', 'Quantity',
      'Discount','Price', 'Address', 'Area'
    ]
    heading
  end
end
