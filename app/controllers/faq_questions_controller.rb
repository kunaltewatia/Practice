# Controller for Faq Question
class FaqQuestionsController < ApplicationController
  include FaqQuestionsHelper
  before_action :set_faq_question, only: [:show, :edit, :update, :destroy]
  before_action :set_faq_category, except: [:destroy]
  before_action :pagination_params, only: [:index]

  def index
    faq_cat_id = params[:faq_category_id]
    @faq_questions = FaqQuestion.includes(:faq_category)
                     .where(faq_category_id: params[:faq_category_id])
                     .paginate(page: @page, per_page: @per_page) if faq_cat_id
    @faq_questions ||= FaqQuestion.includes(:faq_category)
                       .paginate(page: @page, per_page: @per_page)
  end

  def show
  end

  def new
    @faq_question = FaqQuestion.new(faq_category_id: params[:faq_category_id])
  end

  def edit
  end

  def create
    notice = 'Faq question was successfully created.'
    @faq_question = FaqQuestion.new(faq_question_params)
    if @faq_question.save
      redirect_to show_faq_path(@faq_question), notice: notice
    else
      render :new
    end
  end

  def update
    notice = 'Faq question was successfully updated.'
    if @faq_question.update(faq_question_params)
      redirect_to show_faq_path(@faq_question), notice: notice
    else
      render :edit
    end
  end

  def destroy
    notice = 'Faq question was successfully destroyed.'
    @faq_question.destroy
    redirect_to faq_category_faq_questions_path(@faq_question.faq_category_id),
                notice: notice
  end

  private

  def set_faq_question
    @faq_question = FaqQuestion.includes(:faq_category).find(params[:id])
  end

  def faq_question_params
    params.require(:faq_question)
      .permit(:title, :description, :faq_category_id, :is_active)
  end

  def set_faq_category
    @faq_categories = FaqCategory.all
  end
end
