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

require 'rails_helper'

RSpec.describe Service, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
