# metheds of Order Payment Check Module
module OrderPaymentCheckModule
  def fetch_data
    if self.payment_type == '2'
      fetch_payu_data
    elsif self.payment_type == '3'
      fetch_paytm_data
    end
  end

  private

  def notification(params)
    @notification = PayuIndia::Notification.new("", options = { key: Settings.payu_key,
      salt: Settings.payu_salt, params: params })
  end

  def hash_string(txt_id, command = 'verify_payment')
    str = Settings.payu_key + '|' + command + '|' + txt_id + '|' +
          Settings.payu_salt ;
    hash_str =  Digest::SHA512.hexdigest(str)
    hash_str
  end

  def post_data(hash_str, command = 'verify_payment')
    { key: Settings.payu_key, hash: hash_str, var1: txt_id, command: command }
  end

  def status_str(params)
    status = params[:status] || params[:STATUS] || params['STATUS']
    case status
    when 'success' then 'Completed'
    when 'failure' then 'Failed'
    when 'pending' then 'Pending'
    when 'TXN_SUCCESS' then 'Completed'
    when 'TXN_FAILURE' then 'Failed'
    end
  end

  def fetch_payu_data
    hash_str = hash_string(self.txt_id, 'verify_payment')
    post_data = post_data(hash_str, 'verify_payment')
    output = Net::HTTP.post_form(URI(Settings.payu_api), post_data)
    res = JSON.parse(output.body)
    if(res['status'] == 1)
      params = res['transaction_details'][self.txt_id]
      status1 = status_str(params)
      self.update_attribute(:status, status1)
      self.send_notification if status1 == 'Completed'
      self.update_attribute(:response, params)
    end
  end

  def fetch_paytm_data
    uri = URI("#{Settings.paytm_api}{'MID':'#{Settings.mid}'\
      ,'ORDERID':'#{self.txt_id}'}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    params = JSON.parse(http.request(request).body)
    status1 = status_str(params)
    self.update_attribute(:status, status1)
    self.send_notification if status1 == 'Completed'
    self.update_attribute(:response, params)
  end
end