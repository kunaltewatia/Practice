module Api
  module V2
    # PayentHistoriesController
    class PaymentHistoriesController < ApiController
      before_action :authenticate_user!, except: [:payu_details]
      before_action :load_data, only: [:payu_details]

      def payu_details
        if @subscription.nil?
          @subscription = @mobile_user.subscriptions.last
        end
        ph = @subscription.payment_histories.last
        render json: ph, serializer: PaymentHistoryForPayuSerializer
      end

      private

      def load_data
        @mobile_user = MobileUser.find(params[:mobile_user_id])
        @subscription = Subscription.find(params[:subscription_id]) if params[:subscription_id]
      end
    end
  end
end
