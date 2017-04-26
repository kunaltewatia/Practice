# Model for Faq Category
class FaqCategory < ActiveRecord::Base
  belongs_to :service
  has_many :faq_questions

  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) }

  validates :name, :description, :service_id, presence: true
end
