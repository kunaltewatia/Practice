# serializer for faq category
class FaqCategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :is_active
  has_one :service, serializer: FaqServiceSerializer
end
