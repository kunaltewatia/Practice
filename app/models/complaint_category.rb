# ComplaintCategory
class ComplaintCategory < ActiveRecord::Base
  has_many :complaints

  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) }

  validates :name, :description, presence: true
  validates_uniqueness_of :name
end
