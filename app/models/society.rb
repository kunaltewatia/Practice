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

# class Society
class Society < ActiveRecord::Base
  has_many :wings, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :deliveries
  belongs_to :locality

  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) }

  validates :name, presence: true, uniqueness: true
  validates :locality_id, presence: true
  validates :wings, presence: true
  accepts_nested_attributes_for :wings,
                                reject_if: :all_blank, allow_destroy: true
end
