module Api
  module V2
    # SubscriptionsController
    class SubscriptionsController < ApiController
      before_action :authenticate_user!
      before_action :actioned, only: [:create]

      def create
        if permitted_params[:payment_type].zero?
          update_subscription
        else
          @subscription = Subscription.find(permitted_params[:subscription_id]) if permitted_params[:subscription_id]
          @mobile_user = MobileUser.find(permitted_params[:mobile_user_id])
        end
        render json: @mobile_user,
               uuid: current_uuid,
               params: params,
               serializer: MobileUserRegisterSerializer
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
        params.permit(:mobile_user_id, :plan_id, :start_at, :ends_at,
                      :payment_type, :payment_status, :is_active, :is_paused,
                      :pause_start_date, :pause_end_date)
      end

      def actioned
        return if params[:notification_id].nil?
        notification = Notification.find(params[:notification_id])
        notification.update_attribute(:is_actioned, true)
      end

      def update_subscription
        if params[:subscription_id].blank?
          @subscription = Subscription.new(permitted_params)
          @subscription.save!
        else
          @subscription = Subscription.find(params[:subscription_id])
          @subscription.payment_histories.create(
            starts_date: permitted_params[:start_at],
            is_active: false, subscription_type: 'Renew',
            payment_type: permitted_params[:payment_type]
          )
        end
        @mobile_user = @subscription.mobile_user
      end
    end
  end
end
