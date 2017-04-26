# == Schema Information
#
# Table name: areas
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  city_id    :integer
#  is_active  :boolean          default(TRUE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# class Area
class Area < ActiveRecord::Base
  has_many :localities, dependent: :destroy
  has_many :addresses, dependent: :destroy
  belongs_to :city
  has_many :deliveries
  has_many :orders

  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) }

  validates :name, presence: true, uniqueness: true
  validates :city_id, presence: true

  before_create :set_active

  def set_active
    self.is_active = true
  end
end
