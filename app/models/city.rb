# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  state_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# class city
class City < ActiveRecord::Base
  has_many :areas, dependent: :destroy
  has_many :addresses, dependent: :destroy
  belongs_to :state
  has_many :deliveries
  has_many :plans

  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) }

  validates :name, presence: true, uniqueness: true
  validates :state_id, presence: true

  before_create :set_active

  def set_active
    self.is_active = true
  end
end
