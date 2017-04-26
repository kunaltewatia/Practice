module Api
  module V1
    # SubscriptionsController
    class FaqsController < ApiController
      before_action :authenticate_user!

      def index
        if params[:category]
          faq_category_ids = FaqQuestion.active.pluck(:faq_category_id).uniq
          faq_cats = FaqCategory.active
                     .includes(:faq_questions, :service).find(faq_category_ids)
          render json: faq_cats, each_serializer: FaqCatQuestionSerializer
        else
          faq_cats = FaqQuestion.active
          render json: faq_cats, each_serializer: FaqQuestionSerializer
        end
      end

      def categories
        faq_categories = FaqCategory.active.all
        render json: faq_categories, each_serializer: FaqCategorySerializer
      end
    end
  end
end
