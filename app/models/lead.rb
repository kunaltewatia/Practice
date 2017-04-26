# Lead
class Lead < ActiveRecord::Base
  has_one :lead_address, dependent: :destroy
  accepts_nested_attributes_for :lead_address, allow_destroy: true,
                                               reject_if: :all_blank

  validates :lead_address, presence: true
end
