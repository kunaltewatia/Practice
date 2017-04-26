# == Schema Information
#
# Table name: localities
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  area_id    :integer
#  is_active  :boolean          default(TRUE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Class Locality
class Locality < ActiveRecord::Base
  has_many :societies, dependent: :destroy
  has_many :locality_services, dependent: :destroy
  has_many :services, through: :locality_services
  has_many :addresses, dependent: :destroy
  has_many :deliveries
  belongs_to :area
  belongs_to :service

  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) }

  validates :name, presence: true, uniqueness: true
  validates :area_id, presence: true
  accepts_nested_attributes_for :locality_services, allow_destroy: true,
                                                    reject_if: :all_blank
end
