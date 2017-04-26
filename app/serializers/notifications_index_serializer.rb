# Notification serializer
class NotificationsIndexSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :_type, :is_viewed, :is_actioned, :actions,
             :payload, :created_at, :action
  def created_at
    object.created_at.to_i
  end

  def action
    return false if serialization_options[:is_actioned].nil?
    serialization_options[:is_actioned]
  end
end
