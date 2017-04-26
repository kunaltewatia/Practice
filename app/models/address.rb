# Address
class Address < ActiveRecord::Base
  belongs_to :mobile_user
  belongs_to :country
  belongs_to :state
  belongs_to :city
  belongs_to :area
  belongs_to :locality
  belongs_to :society
  belongs_to :wing

  validates :country_id, :state_id, :city_id, :area_id, :locality_id,
            :society_id, :wing_id, :flat_no, presence: true
  validates :flat_no, numericality: { only_integer: true }
end
