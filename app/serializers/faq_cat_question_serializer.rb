# serialzer for faq Questions
class FaqCatQuestionSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :is_active
  has_many :faq_questions, serializer: FaqQuestionSerializer
  has_one :service, serializer: FaqServiceSerializer
end
