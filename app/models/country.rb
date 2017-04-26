# == Schema Information
#
# Table name: countries
#
#  id         :integer          not null, primary key
#  sortname   :string(255)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Class Country
class Country < ActiveRecord::Base
  has_many :states, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :deliveries

  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) }

  validates :name, :sortname, presence: true, uniqueness: true

  before_create :set_active

  def set_active
    self.is_active = true
  end
end
