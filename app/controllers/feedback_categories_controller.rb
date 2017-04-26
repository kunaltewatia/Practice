# FeedbackCategoriesController
class FeedbackCategoriesController < ApplicationController
  before_action :set_feedback_category, only: [:show, :edit, :update, :destroy]
  before_action :pagination_params, only: [:index]
  def index
    @feedback_categories = FeedbackCategory.paginate(page: @page,
                                                     per_page: @per_page)
  end

  def new
    @feedback_category = FeedbackCategory.new
  end

  def create
    @feedback_category = FeedbackCategory.new(feedback_category_params)

    if @feedback_category.save
      redirect_to feedback_categories_url,
                  notice: 'Feedback category was successfully created.'
    else
      render :new
    end
  end

  def update
    if @feedback_category.update(feedback_category_params)
      redirect_to feedback_categories_url,
                  notice: 'Feedback category was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @feedback_category.destroy
    redirect_to feedback_categories_url,
                notice: 'Feedback category was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_feedback_category
    @feedback_category = FeedbackCategory.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white
  # list through.
  def feedback_category_params
    params.require(:feedback_category).permit(:name, :description, :is_active)
  end
end
