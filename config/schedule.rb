require File.expand_path(File.dirname(__FILE__) + '/environment')

env :PATH, ENV['PATH']

set :output, "/var/www/#{Settings.server_name}/shared/log/cron.log"


# In Eastern Standard Time
every 30.minutes do
  runner 'Order.refresh'
end

every 1.day, at: '2:30 pm' do
  runner 'OrderMailer.notify_daily.deliver_now'
end