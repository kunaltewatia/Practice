# Sms Gateway methos for sending sms
module SmsGateway
  SMS_GATEWAY_CONFIG = \
    HashWithIndifferentAccess.new(
      YAML.load_file("#{Rails.root}/config/sms_gateway.yml")[Rails.env])

  def send_sms(args)
    uri = URI(SMS_GATEWAY_CONFIG[:gateway_url])

    params = SMS_GATEWAY_CONFIG[:default_params]
    params[:mobile] = args[:mobile_number]
    params[:message] = args[:message]
    Rails.logger.info(params)
    uri.query = URI.encode_www_form(params)

    res = Net::HTTP.get_response(uri)
    return if res.is_a?(Net::HTTPSuccess)
  end
end
