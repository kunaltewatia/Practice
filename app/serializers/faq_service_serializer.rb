# serializer for faq service
class FaqServiceSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
end
