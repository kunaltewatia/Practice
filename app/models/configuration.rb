# Configuration of Notifications
class Configuration < ActiveRecord::Base
  validates :name, presence: true
  validates_uniqueness_of :name
end
