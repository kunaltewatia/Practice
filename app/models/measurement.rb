# == Schema Information
#
# Table name: measurements
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  unit       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# class Measurement
class Measurement < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :unit, presence: true
end
