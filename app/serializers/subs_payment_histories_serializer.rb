# subscription payment histories
class SubsPaymentHistoriesSerializer < ActiveModel::Serializer
  attributes :id, :subscription_id, :starts_date, :ends_date, :is_active,
             :subscription_type, :is_paid, :mode, :status
end
