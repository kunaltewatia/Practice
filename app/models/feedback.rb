# Feedback
class Feedback < ActiveRecord::Base
  belongs_to :mobile_user
  belongs_to :user
  belongs_to :feedback_category

  validates :text, :mobile_user_id, :feedback_category_id, presence: true

  def listing_parameters
    { date: created_at.to_date, category_name: feedback_category.name,
      type: 'F', is_resolved: is_resolved, text: text,
      admin_comment: admin_comment }
   end
end
