# Lead Address
class LeadAddress < ActiveRecord::Base
  belongs_to :lead
  belongs_to :country
  belongs_to :state
  belongs_to :city

  validates :country_id, :state_id, :city_id, presence: true
end
