# SubscriptionsController
class SubscriptionsController < ApplicationController
  before_filter :set_pack, except: [:index]
  before_filter :set_subscription, except: [:index, :create, :new, :renew,
                                            :create_renew]

  def new
    @subscription = Subscription.new
    respond_to do |format|
      format.js { render :new }
    end
  end

  def create
    @subscription = Subscription.new(permitted_params)
    @subscription.save
    respond_to do |format|
      format.js { render :create }
    end
  end

  def edit
    respond_to do |format|
      format.js { render :edit }
    end
  end

  def update
    @subscription.update_attributes(permitted_params)
    @subscription.save
    respond_to do |format|
      format.js { render :update }
    end
  end

  def destroy
    @subscription.destroy
    redirect_to customer_url(@subscription.mobile_user),
                notice: 'Subscription was successfully destroyed.'
  end

  def renew
    @subscription = Subscription.find(params[:subscription_id])
    respond_to do |format|
      format.js { render :renew }
    end
  end

  def create_renew
    subscription = Subscription.find(params[:subscription_id])
    subscription.payment_histories.create(
      starts_date: params[:renew][:start_at],
      is_active: false, subscription_type: 'Renew', payment_type: '0')
    respond_to do |format|
      format.js { render :create_renew }
    end
  end

  private

  def set_pack
    @packs = Pack.select('id', 'name').active
  end

  def set_subscription
    @subscription = Subscription.includes(:subscription_pauses,
                                          :payment_histories,
                                          plan: [:pack]).find(params[:id])
  end

  def permitted_params
    params.require(:subscription).permit(:id, :mobile_user_id, :plan_id,
                                         :start_at, :ends_at, :payment_type,
                                         :payment_status, :is_active)
  end
end
