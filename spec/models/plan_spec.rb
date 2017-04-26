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

require 'rails_helper'

RSpec.describe Plan, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
