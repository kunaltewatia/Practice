# FeedbacksController
class FeedbacksController < ApplicationController
  before_action :set_feedback, only: [:show, :edit, :update, :destroy]
  before_action :pagination_params, only: [:index]

  def index
    @feedbacks = Feedback.paginate(page: @page, per_page: @per_page)
  end

  def update
    if @feedback.update(feedback_params)
      redirect_to feedbacks_url,
                  notice: 'Feedback was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @feedback.destroy
    redirect_to feedbacks_url, notice: 'Feedback was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_feedback
    @feedback = Feedback.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the
  #  white list through.
  def feedback_params
    params.require(:feedback).permit(:mobile_user_id, :user_id, :text,
                                     :admin_comment, :is_resolved,
                                     :feedback_category_id)
  end
end
