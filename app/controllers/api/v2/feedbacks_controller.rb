# FeedbacksController
module Api
  module V2
    # FeedbacksController
    class FeedbacksController < ApiController
      before_action :authenticate_user!
      def create
        feedback = Feedback.new(feedback_params)
        feedback.save!
        render json: feedback, serializer: CreateFeedbackSerializer
      end

      private

      def feedback_params
        params.require(:feedback)
          .permit(:mobile_user_id, :feedback_category_id, :text)
      end
    end
  end
end
