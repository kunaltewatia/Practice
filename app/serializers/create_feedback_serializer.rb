class CreateFeedbackSerializer < ActiveModel::Serializer
  attributes :id, :mobile_user_id, :text, :feedback_category_id
end
