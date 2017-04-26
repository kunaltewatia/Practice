# PaymentHistoriesHelper
module PaymentHistoriesHelper
  def options_of_pay
    options_for_select(
      [['Unpaid', 0], ['Paid', 1]], selected: @payment_history.is_paid ? 1 : 0)
  end
end
