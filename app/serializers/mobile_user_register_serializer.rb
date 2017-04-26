# MobileUserRegisterSerializer
class MobileUserRegisterSerializer < ActiveModel::Serializer
  attributes :id, :mobile_number, :is_verified, :first_name, :last_name,
             :udf1, :udf2, :udf3, :udf4, :payment_type

  # Subscription Id
  def udf1
    return if serialization_options[:params].blank?
    serialization_options[:params][:subscription_id]
  end

  # mobile user id
  def udf2
    object.id
  end

  # plan id
  def udf3
    return if serialization_options[:params].blank?
    serialization_options[:params][:plan_id]
  end

  # start at date
  def udf4
    return if serialization_options[:params].blank?
    serialization_options[:params][:start_at]
  end

  def payment_type
    return 0 if serialization_options[:params].blank?
    serialization_options[:params][:payment_type]
  end
end
