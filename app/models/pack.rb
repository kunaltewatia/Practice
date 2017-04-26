# == Schema Information
#
# Table name: packs
#
#  id          :integer          not null, primary key
#  service_id  :integer
#  name        :string(255)
#  description :text(65535)
#  is_active   :boolean          default(TRUE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# class Pack ( SOLO,Family)
class Pack < ActiveRecord::Base
  has_many :plans, dependent: :destroy
  has_many :deliveries
  belongs_to :service

  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) }

  validates :name, presence: true, uniqueness: true
  validates :description, :service_id, presence: true
end
