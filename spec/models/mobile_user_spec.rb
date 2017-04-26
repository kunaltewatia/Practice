# == Schema Information
#
# Table name: mobile_users
#
#  id             :integer          not null, primary key
#  mobile_number  :string(255)
#  uuid           :string(255)
#  is_verified    :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  otp_secret_key :string(255)
#

require 'rails_helper'

RSpec.describe MobileUser, type: :model do
  pending 'add some examples to (or delete) #{__FILE__}'
end
