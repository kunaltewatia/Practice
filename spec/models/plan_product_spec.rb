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

require 'rails_helper'

RSpec.describe PlanProduct, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
