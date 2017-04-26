# SubscriptionPausesControll
class SubscriptionPausesController < ApplicationController
  before_action :process_pauses, only: [:create]

  def index
    result = {}
    result[:customer_pauses] = SubscriptionPause
                               .pause_dates(params[:subscription_id])
                               .pluck('date')
    result[:system_pauses] = SubscriptionPause
                             .system_pauses(params[:subscription_id])
                             .pluck('date')
    render json: result
  end

  def new
    @subscription = Subscription.find(params[:subscription_id])
    respond_to do |format|
      format.js { render :new }
    end
  end

  def create
    dates = permitted_params[:date].split(',').map(&:to_date)
    if dates.present?
      dates.each do |date|
        create_pauses(date) if date.wday != 0
      end
    end
    @subscription.update_ends_at
    respond_to do |format|
      format.js { render :create }
    end
  end

  private

  def create_pauses(date)
    subscription_pause = SubscriptionPause.new(
      mobile_user_id: permitted_params[:mobile_user_id],
      date: date,
      payment_history_id: @subscription.payment_histories.last.id,
      subscription_id: permitted_params[:subscription_id])
    subscription_pause.save(validate: false)
  rescue => e
    logger.info "Error : #{e.inspect}"
  end

  def process_pauses
    @subscription = Subscription.find(permitted_params[:subscription_id])
    next_pauses = @subscription.subscription_pauses
    remove_pauses(next_pauses)
    @subscription.save!
    @subscription.subscription_pauses.destroy_all
  end

  def remove_pauses(next_pauses)
    next_pauses.count.times do
      if @subscription.ends_at.wday == 1
        @subscription.ends_at -= 2.day
      else
        @subscription.ends_at -= 1.day
      end
    end
    @subscription.ends_at -= 1.day if @subscription.ends_at.day == 0
  end

  def permitted_params
    params.require(:pause_subscription).permit(:id, :mobile_user_id,
                                               :subscription_id, :date)
  end
end
