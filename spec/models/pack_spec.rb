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

require 'rails_helper'

RSpec.describe Pack, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
