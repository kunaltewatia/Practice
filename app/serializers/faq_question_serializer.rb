# serialzer for faq Questions
class FaqQuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :is_active
end
