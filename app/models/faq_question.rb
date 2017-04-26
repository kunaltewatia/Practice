# Class for FAQ
class FaqQuestion < ActiveRecord::Base
  belongs_to :faq_category

  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) }

  validates :title, :description, :faq_category_id, presence: true
end
