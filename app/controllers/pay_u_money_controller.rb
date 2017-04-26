class PayUMoneyController < ApplicationController
  include EncryptionNewPG
  protect_from_forgery
  before_filter :authenticate_user!, except: [:payu_success, :payu_failure,
                                              :index, :payu, :export]
  before_filter :notification, except: [:index, :payu, :export]
  before_filter :create_paytm, only: [:payu]
  before_filter :my_logger

  def payu_success
    @order = find_user(params)
    redirect_on_failure
    return unless success?
    @order.send_notification
    @order.update_attribute(:status, status_str(params))
    @order.update_attribute(:is_paid, true)
    update_payment_history(@order, params)
    reset_session
  end

  def payu_failure
    @order = Order.find(params[:udf1])
    redirect_to "/review/#{@order.id}"
  end

  def payu
    if @order.cod?
      @order.send_notification_cod
      @order.update_attribute(:status, 'Pending')
      reset_session
      render :payu_success
    end
  end

  def export
    @order = Order.find_by(txt_id: params[:id])
    pdf = render_to_string pdf: @order.txt_id,
          template: 'pay_u_money/_export_receipt.html.erb',
          layout: "layouts/pdf.html.erb",
          print_media_type: true,
          page_size: "A4",
          disable_smart_shrinking: true
    send_data(pdf, filename: @order.txt_id + '.pdf',  type: "application/pdf")
  end

  private

  def update_payment_history(order, params)
    order.response = params
    order.save
  end

  def notification
    @notification = PayuIndia::Notification.new(request.query_string, options = { key: Settings.payu_key,
      salt: Settings.payu_salt, params: params })
  end

  def create_paytm
    @order = Order.find(params[:id])
    @param_list = {
      'MID': Settings.mid, 'ORDER_ID': @order.txt_id, 'CUST_ID': @order.id,
      'INDUSTRY_TYPE_ID': Settings.industry_type_id, 'CHANNEL_ID': Settings.channel_id,
      'TXN_AMOUNT': @order.price,
      'MSISDN': @order.mobile_number, 'EMAIL': '',
      'WEBSITE': Settings.website, 'CALLBACK_URL': Settings.payu_surl
    }
    @checksum_hash = new_pg_checksum(@param_list, Settings.paytm_merchant_key)
                     .gsub("\n", '')
  end

  def find_user(params)
    if params[:udf1].present?
      @order = Order.find(params[:udf1])
    else
      @order = Order.find_by_txt_id(params[:ORDERID])
    end
  end


  def my_logger
    @my_logger ||= Logger.new("#{Rails.root}/log/payment.log")
    @my_logger.info('**************************************')
    @my_logger.info(request.fullpath)
    @my_logger.info('Params ' + params.to_json)
    @my_logger.info('**************************************')
  end

  def status_str(params)
    status = params[:status] || params[:STATUS]
    case status
    when 'success' then 'Completed'
    when 'failure' then 'Failed'
    when 'pending' then 'Pending'
    when 'TXN_SUCCESS' then 'Completed'
    when 'TXN_FAILURE' then 'Failed'
    end
  end

  def redirect_on_failure
    return if success?
    @order.txt_id = "M-#{@order.id}-#{DateTime.current.to_i}"
    @order.save
    redirect_to "/review/#{@order.id}" and return
  end

  def success?
    params[:status] == 'success' || params[:STATUS] == 'TXN_SUCCESS'
  end
end
