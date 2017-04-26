module Api
  module V1
    # SubscriptionsController
    class SubscriptionsController < ApiController
      before_action :authenticate_user!
      before_action :actioned, only: [:renew]

      def create
        subscription = Subscription.new(permitted_params)
        subscription.save!
        render json: subscription
      end

      def renew
        subscription = Subscription.find(params[:id])
        subscription.payment_histories.create(
          starts_date: permitted_params[:start_at],
          is_active: false, subscription_type: 'Renew'
        )
        render json: subscription
      end

      def customer_subscriptions
        mobile_user = MobileUser.find_by_mobile_number!(current_mobile_number)
        render json: mobile_user,
               serializer: MySubscriptionSerializer
      end

      def update
        subscription = Subscription.find(params[:id])
        subscription.update_attributes(permitted_params)
        render json: subscription, serializer: UpdateSubscriptionSerializer
      end

      private

      def permitted_params
        params.permit(:id, :mobile_user_id, :plan_id, :start_at, :ends_at,
                      :payment_type, :payment_status, :is_active, :is_paused,
                      :pause_start_date, :pause_end_date)
      end

      def actioned
        return if params[:notification_id].nil?
        notification = Notification.find(params[:notification_id])
        notification.update_attribute(:is_actioned, true)
      end
    end
  end
end
