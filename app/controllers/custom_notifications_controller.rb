# Custom Notifications Controller
class CustomNotificationsController < ApplicationController
  def index
    @custom_notification = CustomNotification.new
  end

  def new
  end

  def create
    @custom_notification = CustomNotification.new(custom_notification_params)
    if @custom_notification.save
      redirect_to custom_notifications_url,
                  notice: 'Notification was successfully sent.'
    else
      render :new
    end
  end

  private

  def custom_notification_params
    params.require(:custom_notification)
      .permit(:status, :message, :is_sms, :is_notification)
  end
end
