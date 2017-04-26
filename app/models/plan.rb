# == Schema Information
#
# Table name: plans
#
#  id          :integer          not null, primary key
#  pack_id     :integer
#  name        :string(255)
#  description :text(65535)
#  old_price   :decimal(10, )
#  price       :decimal(10, )
#  days        :integer
#  is_active   :boolean          default(TRUE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# class Plan
class Plan < ActiveRecord::Base
  has_many :packages, dependent: :destroy
  has_many :deliveries
  has_many :orders
  belongs_to :pack
  belongs_to :product
  belongs_to :city

  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) }

  # validates_uniqueness_of :name, scope: :product_id
  validates :product_id, presence: true
  validates :city_id, presence: true
  validates :name, presence: true
  # validates :old_price, presence: true, numericality: true
  validates :price, presence: true, numericality: true
  # validates :days, presence: true, numericality: { only_integer: true }
end
