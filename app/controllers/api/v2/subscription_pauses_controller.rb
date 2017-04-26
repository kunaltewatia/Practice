module Api
  module V2
    # SubscriptionPausesController
    class SubscriptionPausesController < ApiController
      before_action :authenticate_user!
      before_action :process_pauses, only: [:create]
      before_action :actioned, only: [:create]

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

      def create
        @subscription_pauses = []
        if permitted_params[:date].present?
          permitted_params[:date].each do |date|
            create_pauses(date) if Date.parse(date).wday != 0
          end
        end
        @subscription.update_ends_at
        send_response
      end

      def send_response
        result = {}
        if @subscription_pauses.empty?
          result[:message] = 'Failed to Pause'
        else
          result[:message] =
            @subscription_pauses.join(', ') << ' Sucecessfully Paused'
        end
        render json: result
      end

      def customerwise
        paused_subscriptions = current_user.subscription_pauses
        render json: paused_subscriptions,
               each_serializer: CustomerwisePausedSerializer
      end

      private

      def process_pauses
        @subscription = Subscription.find(permitted_params[:subscription_id])
        next_pauses = @subscription.subscription_pauses.next_pauses
        remove_pauses(next_pauses)
        @subscription.save!
        @subscription.subscription_pauses.next_pauses.destroy_all
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
        params.permit(:id, :mobile_user_id, :subscription_id, date: [])
      end

      def create_pauses(date)
        subscription_pause = SubscriptionPause.new(
          mobile_user_id: permitted_params[:mobile_user_id],
          date: date,
          payment_history_id: @subscription.payment_histories.last.id,
          subscription_id: permitted_params[:subscription_id])
        subscription_pause.save!
        @subscription_pauses << subscription_pause.date
      rescue => e
        logger.info "Error : #{e.inspect}"
      end

      def actioned
        return if params[:notification_id].nil?
        notification = Notification.find(params[:notification_id])
        notification.update_attribute(:is_actioned, true)
      end
    end
  end
end
