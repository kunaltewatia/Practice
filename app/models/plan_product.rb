# == Schema Information
#
# Table name: plan_products
#
#  id             :integer          not null, primary key
#  product_id     :integer
#  package_id     :integer
#  measurement_id :integer
#  date           :date
#  quantity       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

# Plan Product class
class PlanProduct < ActiveRecord::Base
  belongs_to :product
  belongs_to :package
  belongs_to :measurement
  self.per_page = 10
end
