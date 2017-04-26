class MobileUserVerifiedSerializer < ActiveModel::Serializer
  attributes :id, :mobile_number, :uuid, :is_verified, :first_name, :last_name,
             :auth_token

  def auth_token
    object.authentications.find_by_uuid(serialization_options[:uuid]).auth_token
  end

  def uuid
    object.authentications.find_by_uuid(serialization_options[:uuid]).uuid
  end
end
