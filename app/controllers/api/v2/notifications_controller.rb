module Api
  module V2
    # Notifications Controller
    class NotificationsController < ApiController
      before_action :authenticate_user!
      before_action :set_notification, only: [:index]

      def index
        render json: @notifications,
               each_serializer: NotificationsIndexSerializer
      end

      def viewed
        notification = Notification.find(params[:id])
        notification.update_attribute(:is_viewed, true)
        render json: { message: 'Notification Update' }
      end

      def show
        @actioned = false
        @notification = Notification.find(params[:id])
        if @notification.is_actioned
          @is_actioned = true
          @notification = Notification.where(
            mobile_user_id: current_user.id, is_actioned: false).last
        end
        render json: @notification, is_actioned: @is_actioned,
               serializer: NotificationsIndexSerializer
      end

      private

      def set_notification
        if params[:date].present?
          date = timestamp_to_date(params[:date])
          @notifications = Notification.where(
            mobile_user_id: current_user.id, is_viewed: false)
                           .where('created_at > ?', date)
        else
          @notifications = Notification.where(mobile_user_id: current_user.id)
                           .limit(20)
        end
      end

      def timestamp_to_date(date)
        Time.at(date.to_i).to_datetime
      end
    end
  end
end
