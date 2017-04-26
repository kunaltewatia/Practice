# Notification Model
class Notification < ActiveRecord::Base
  serialize :actions
  serialize :payload

  belongs_to :mobile_user
  belongs_to :subscription
end
