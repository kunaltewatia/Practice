# UpdateSubscriptionSerializer
class UpdateSubscriptionSerializer < ActiveModel::Serializer
  attributes :id, :pause_start_date, :pause_end_date,
             :is_paused, :plan, :is_active
end
