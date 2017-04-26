# LocalityService model
class LocalityService < ActiveRecord::Base
  belongs_to :service
  belongs_to :locality

  validates :service_id, presence: true
  validates_uniqueness_of :service_id, scope: [:locality_id]

  self.per_page = 10
end
