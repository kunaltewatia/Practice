class FeedbackSerializer < ActiveModel::Serializer
  attributes :id, :text, :admin_comment, :is_resolved
  has_one :mobile_user
  has_one :user
  has_one :feedback_category
end
