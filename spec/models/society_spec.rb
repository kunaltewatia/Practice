# == Schema Information
#
# Table name: societies
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  locality_id  :integer
#  latitude     :string(255)
#  longlatitude :string(255)
#  is_active    :boolean          default(TRUE), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Society, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
