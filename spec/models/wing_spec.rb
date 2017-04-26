# == Schema Information
#
# Table name: wings
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  society_id :integer
#  is_active  :boolean          default(TRUE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Wing, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
