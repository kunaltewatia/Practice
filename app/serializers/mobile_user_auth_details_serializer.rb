# mobile user auth details
class MobileUserAuthDetailsSerializer < ActiveModel::Serializer
  attributes :id, :mobile_number, :is_verified, :first_name, :last_name,
             :is_subscribed, :auth_token, :uuid

  def auth_token
    object.authentications.find_by_uuid(serialization_options[:uuid]).auth_token
  end

  def uuid
    object.authentications.find_by_uuid(serialization_options[:uuid]).uuid
  end

  def is_subscribed
    object.subscriptions.present?
  end
end
