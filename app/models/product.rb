# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  service_id  :integer
#  name        :string(255)
#  origin      :string(255)
#  description :text(65535)
#  is_active   :boolean          default(TRUE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# Product class
class Product < ActiveRecord::Base
  mount_uploader :banner, ImageUploader
  mount_uploader :listing, ImageUploader
  mount_uploader :side, ImageUploader

  belongs_to :service
  has_many :plans
  has_many :orders
  validates :name, presence: true, uniqueness: true
  validates :service_id, presence: true

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      all
    end
  end

  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) }
end
