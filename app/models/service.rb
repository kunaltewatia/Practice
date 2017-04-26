# == Schema Information
#
# Table name: services
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text(65535)
#  parent_id   :integer
#  is_active   :boolean          default(TRUE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# Service class
class Service < ActiveRecord::Base
  has_many :packs, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :locality_services
  has_many :localities, through: :locality_services
  has_many :child_services, class_name: 'Service', foreign_key: :parent_id

  belongs_to :parent, class_name: 'Service'
  belongs_to :locality

  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) }

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
