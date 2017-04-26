# == Schema Information
#
# Table name: packages
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  plan_id    :integer
#  date       :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Package class
class Package < ActiveRecord::Base
  has_many :plan_products, dependent: :destroy
  has_many :products, through: :plan_products
  belongs_to :plan

  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) }

  accepts_nested_attributes_for :plan_products

  validates :name, presence: true, uniqueness: true
  validates :plan_id, :date, presence: true
  self.per_page = 10
end
