# PaymentHistoriesController
class PaymentHistoriesController < ApplicationController
  before_action :set_pay_history
  def edit
    respond_to do |format|
      format.js { render :edit }
    end
  end

  def update
    @payment_history.update(is_paid: params[:is_paid])
    subscription = @payment_history.subscription
    redirect_to customer_subscription_path(
      customer_id: subscription.mobile_user_id, id: subscription.id),
                notice: 'Payment Status successfully updated.'
  end

  def destroy
    subscription = @payment_history.subscription
    @payment_history.destroy
    redirect_to customer_subscription_path(
      customer_id: subscription.mobile_user_id, id: subscription.id),
                notice: 'Payment successfully deleted.'
  end

  private

  def set_pay_history
    @payment_history = PaymentHistory.find(params[:id])
  end
end
