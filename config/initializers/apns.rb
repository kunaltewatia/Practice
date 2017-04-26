require 'houston'

if Rails.env.production?
  APN = Houston::Client.production
  APN.certificate = File.read(Rails.root.join('ck_prod.pem'))
  APN.passphrase = 'abcd1234'
else
  APN = Houston::Client.development
  APN.certificate = File.read(Rails.root.join('ck.pem'))
  APN.passphrase = 'swapnil6186'
end
