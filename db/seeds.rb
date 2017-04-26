User.create!(email: 'admin@frools.com', password: 'frools@2015',
             password_confirmation: 'frools@2015')

reminders = [
  'Renewal Reminder', 'First Reminder', 'Second Reminder', 'Last Reminder',
  'Pause Reminder', 'Complaint Resolution Reminder', 'Payment Received',
  'Payment Past Due'
]
reminders.each { |reminder| Configuration.create(name: reminder) }

