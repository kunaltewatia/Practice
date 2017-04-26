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

# Class wing
class Wing < ActiveRecord::Base
  has_many :addresses, dependent: :destroy
  has_many :deliveries
  belongs_to :society
  validates :name, uniqueness: { scope: :society_id }
  validates :name, presence: true
end
